require 'test_helper'


describe 'DirectPay24Sale JSON Schema' do
  let(:schema_path){ schema_path_for('direct_pay24_sale') }
  subject{ fixture('direct_pay24_sale') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'direct_pay24_sale'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'

  spec_attribute 'wire_reference_id'
  spec_attribute 'bank_account_holder', required: true
  spec_attribute 'bank_account_number', required: true
  spec_attribute 'bank_number'        , required: true

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'shipping_address', spec: 'billing_address'
  spec_attribute 'risk_params'
  spec_attribute 'meta'

  spec_attribute 'notification_url',   spec: 'url'
  spec_attribute 'return_success_url', spec: 'url'
  spec_attribute 'return_failure_url', spec: 'url'
end