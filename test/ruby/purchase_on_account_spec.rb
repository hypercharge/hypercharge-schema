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

  spec_attribute 'wire_reference_id'  , required: false
  spec_attribute 'company_name'       , required: false
  spec_attribute 'bank_account_holder', required: false
  spec_attribute 'bank_account_number', required: false
  spec_attribute 'bank_number'        , required: false
  spec_attribute 'iban'               , required: false
  spec_attribute 'bic'                , required: false

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'shipping_address', required: false, spec: 'billing_address'

  spec_attribute 'risk_params_birthday', required: false
  spec_attribute 'meta'
end