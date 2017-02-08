require 'test_helper'


describe 'DebitSale JSON Schema' do
  let(:schema_path){ schema_path_for('debit_sale') }
  subject{ fixture('debit_sale') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'debit_sale'
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
end