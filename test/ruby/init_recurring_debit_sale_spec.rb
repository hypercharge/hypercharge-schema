require 'test_helper'


describe 'InitRecurringDebitSale JSON Schema' do
  let(:schema_path){ schema_path_for('init_recurring_debit_sale') }
  subject{ fixture('init_recurring_debit_sale') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'init_recurring_debit_sale'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'

  spec_attribute 'wire_reference_id'
  spec_attribute 'bank_account_holder', required: true
  spec_attribute 'bank_account_number', required: false
  spec_attribute 'bank_number'        , required: false
  spec_attribute 'iban'               , required: false
  spec_attribute 'bic'                , required: false
  spec_attribute 'sepa_mandate_id'    , required: false
  spec_attribute 'sepa_mandate_signature_date', required: false, spec: 'date'

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true
  spec_attribute 'shipping_address', spec: 'billing_address'
  spec_attribute 'risk_params'
  spec_attribute 'recurring_schedule'
end