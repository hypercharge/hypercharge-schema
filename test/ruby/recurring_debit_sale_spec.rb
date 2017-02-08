require 'test_helper'


describe 'RecurringDebitSale JSON Schema' do
  let(:schema_path){ schema_path_for('recurring_debit_sale') }
  subject{ fixture('recurring_debit_sale') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'recurring_debit_sale'
  spec_attribute 'reference_id', spec: 'unique_id'
  spec_attribute 'transaction_id'
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount'
  spec_attribute 'currency'
  spec_attribute 'meta'
end