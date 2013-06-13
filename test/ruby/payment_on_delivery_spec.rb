require 'test_helper'


describe 'PaymentOnDelivery JSON Schema' do
  let(:schema_path){ schema_path_for('payment_on_delivery') }
  subject{ fixture('payment_on_delivery') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'payment_on_delivery'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'risk_params'
end