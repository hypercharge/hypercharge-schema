require 'test_helper'


describe 'MobilePayment JSON Schema' do
  let(:schema_path){ schema_path_for('MobilePayment') }
  subject{ fixture('MobilePayment') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'type', value: 'MobilePayment'
  spec_attribute 'transaction_types'
  spec_attribute 'amount'
  spec_attribute 'currency'
  spec_attribute 'transaction_id'
  spec_attribute 'usage', required: true
  spec_attribute 'payment_card_holder'
  spec_attribute 'customer_email', required: false
  spec_attribute 'customer_phone'
  spec_attribute 'notification_url',   spec: 'url'
  spec_attribute 'billing_address', required: false
  spec_attribute 'retries'
  spec_attribute 'risk_params'
  spec_attribute 'meta'
  spec_attribute 'recurring_schedule'
end