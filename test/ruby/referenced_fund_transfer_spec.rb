require 'test_helper'


describe 'ReferencedFundTransfer JSON Schema' do
  let(:schema_path){ schema_path_for('referenced_fund_transfer') }
  subject{ fixture('referenced_fund_transfer') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'referenced_fund_transfer'
  spec_attribute 'reference_id', spec: 'unique_id'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'
  spec_attribute 'meta'
end