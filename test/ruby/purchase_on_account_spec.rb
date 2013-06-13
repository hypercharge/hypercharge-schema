require 'test_helper'


describe 'PurchaseOnAccount JSON Schema' do
  let(:schema_path){ schema_path_for('purchase_on_account') }
  subject{ fixture('purchase_on_account') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'purchase_on_account'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'

  spec_attribute  'wire_reference_id'

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'risk_params'
end