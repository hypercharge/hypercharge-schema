require 'test_helper'


describe 'WpfPayment JSON Schema' do
  let(:schema_path){ schema_path_for('WpfPayment') }
  subject{ fixture('WpfPayment') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'type', value: 'WpfPayment'
  spec_attribute 'transaction_types'
  spec_attribute 'amount'
  spec_attribute 'currency'
  spec_attribute 'transaction_id'
  spec_attribute 'usage', required: true
  spec_attribute 'description'
  spec_attribute 'editable_by_user'
  spec_attribute 'payment_card_holder'
  spec_attribute 'customer_email', required: false
  spec_attribute 'customer_phone'
  spec_attribute 'notification_url',   spec: 'url'
  spec_attribute 'return_success_url', spec: 'url'
  spec_attribute 'return_failure_url', spec: 'url'
  spec_attribute 'return_cancel_url',  spec: 'url'
  spec_attribute 'billing_address'
  spec_attribute 'retries'
  spec_attribute 'risk_params'
  spec_attribute 'meta'
  spec_attribute 'recurring_schedule'
end