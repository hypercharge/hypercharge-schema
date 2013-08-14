# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'types_specs'


class FixtureInvalidError < StandardError
end

# works with minitest 4.x and 5.x
class MiniTest::Spec

  before do
    errors = JSON::Validator.fully_validate(schema_path, subject, :version => :draft3)
    unless errors.size.zero?
      raise FixtureInvalidError, errors.inspect
    end
  end

  def validate(schema_path, data)
     JSON::Validator.validate(schema_path, data, :version => :draft3)
  end

  def schema_path_for(name)
    File.expand_path("../../../json/#{name}.json", __FILE__)
  end

  def fixture(name)
    JSON.parse(IO.read(File.expand_path("../../fixtures/requests/#{name}.json", __FILE__)))
  end


  class << self
    def wont_allow_additional_properties
      describe 'root' do
        it 'wont allow additionalProperties' do
          subject['notInSchema'] = 1
          validate(schema_path, subject).must_equal false
        end
      end
    end

    def root_wont_allow_additional_properties
      describe 'root' do
        it 'wont allow additionalProperties' do
          subject[root_key]['notInSchema'] = 1
          validate(schema_path, subject).must_equal false
        end
      end
    end

    def spec_attribute attr_name, options = {}
      spec_name = options[:spec] || attr_name
      spec_proc = TypesSpecs.proc_for(spec_name)

      options[:required] ||= false

      raise "Spec for #{spec_name} missing" unless spec_proc

      cls = describe attr_name, &spec_proc
      # add some attr_name and options as locals
      cls.class_eval do
        let(:attr_name) { attr_name }
        options.each do |k, v|
          let(k){ v }
        end
      end
    end
  end
end
