require 'test_helper'


describe 'Authorize JSON Schema' do
  let(:schema_path){ schema_path_for('authorize') }
  subject{ fixture('authorize') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'authorize'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'
  spec_attribute 'card_holder'
  spec_attribute 'card_number'
  spec_attribute 'cvv'
  spec_attribute 'expiration_month'
  spec_attribute 'expiration_year'
  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'shipping_address', spec: 'billing_address'
  spec_attribute 'risk_params'
end