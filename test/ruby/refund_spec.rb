require 'test_helper'


describe 'Refund JSON Schema' do
  let(:schema_path){ schema_path_for('refund') }
  subject{ fixture('refund') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'refund'
  spec_attribute 'reference_id', spec: 'unique_id'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'amount'
  spec_attribute 'currency'
end