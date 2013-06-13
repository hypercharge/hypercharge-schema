# encoding: UTF-8

require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'debugger'
require 'types_specs'

# require 'turn'
# Turn.config.format = :progress


class FixtureInvalidError < StandardError
end

class Minitest::Spec
  def schema_path_for(name)
    File.expand_path("../../../json/#{name}.json", __FILE__)
  end

  def fixture(name)
    JSON.parse(IO.read(File.expand_path("../../fixtures/requests/#{name}.json", __FILE__)))
  end

  def self.root_wont_allow_additional_properties
    describe 'root' do
      it 'wont allow additionalProperties' do
        subject[root_key]['notInSchema'] = 1
        JSON::Validator.validate(schema_path, subject).must_equal false
      end
    end
  end

  def self.spec_attribute attr_name, options = {}
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

  before do
    errors = JSON::Validator.fully_validate(schema_path, subject)
    unless errors.size.zero?
      raise FixtureInvalidError, errors.inspect
    end
  end
end