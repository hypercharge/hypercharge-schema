require 'test_helper'


describe 'PayPal JSON Schema' do
  let(:schema_path){ schema_path_for('pay_pal') }
  subject{ fixture('pay_pal') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'pay_pal'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'shipping_address', spec: 'billing_address'
  # spec_attribute 'risk_params'

  spec_attribute 'notification_url',   spec: 'url'
  spec_attribute 'return_success_url', spec: 'url'
  spec_attribute 'return_failure_url', spec: 'url'
end