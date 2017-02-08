require 'test_helper'


describe 'Void JSON Schema' do
  let(:schema_path){ schema_path_for('void') }
  subject{ fixture('void') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'void'
  spec_attribute 'reference_id', spec: 'unique_id'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'meta'
end