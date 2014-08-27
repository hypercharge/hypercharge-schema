require 'test_helper'


describe 'iDealSale JSON Schema' do
  let(:schema_path){ schema_path_for('ideal_sale') }
  subject{ fixture('ideal_sale') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'ideal_sale'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'

  spec_attribute 'bank_account_holder', required: true
  spec_attribute 'bank_name'          , required: false
  spec_attribute 'bank_account_number', required: false
  spec_attribute 'bank_number'        , required: false

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'shipping_address', spec: 'billing_address'
  spec_attribute 'risk_params'

  spec_attribute 'notification_url',   spec: 'url'
  spec_attribute 'return_success_url', spec: 'url'
  spec_attribute 'return_failure_url', spec: 'url'
end