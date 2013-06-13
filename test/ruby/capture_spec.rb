require 'test_helper'


describe 'Capture JSON Schema' do
  let(:schema_path){ schema_path_for('capture') }
  subject{ fixture('capture') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'capture'
  spec_attribute 'reference_id', spec: 'unique_id'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'amount'
  spec_attribute 'currency'
end