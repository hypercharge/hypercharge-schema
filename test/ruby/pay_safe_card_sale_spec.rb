require 'test_helper'


describe 'PaySafeCardSale JSON Schema' do
  let(:schema_path){ schema_path_for('pay_safe_card_sale') }
  subject{ fixture('pay_safe_card_sale') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'transaction_type', value: 'pay_safe_card_sale'
  spec_attribute 'transaction_id', required: true
  spec_attribute 'usage'
  spec_attribute 'remote_ip', required: true
  spec_attribute 'amount', required: true
  spec_attribute 'currency', required: true

  spec_attribute 'customer_email', required: true
  spec_attribute 'customer_phone'
  spec_attribute 'billing_address', required: true

  spec_attribute 'notification_url',   spec: 'url'
  spec_attribute 'return_success_url', spec: 'url'
  spec_attribute 'return_failure_url', spec: 'url'
end