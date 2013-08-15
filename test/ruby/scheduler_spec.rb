require 'test_helper'


describe 'Scheduler.create JSON Schema' do
  let(:schema_path){ schema_path_for('scheduler_create') }
  subject{ fixture('scheduler_create') }

  wont_allow_additional_properties
  spec_attribute 'payment_transaction_unique_id', spec: 'v2_unique_id', required: true
  spec_attribute 'amount'    , spec: 'v2_amount' , required: true
  spec_attribute 'start_date', spec: 'date'      , required: true
  spec_attribute 'end_date'  , spec: 'date'
  spec_attribute 'interval'  , spec: 'recurring_interval' , required: true
  spec_attribute 'expiring_notification_time'
  spec_attribute 'active'
end

describe 'Scheduler.update JSON Schema' do
  let(:schema_path){ schema_path_for('scheduler_update') }
  subject{ fixture('scheduler_update') }

  wont_allow_additional_properties
  spec_attribute 'amount'    , spec: 'v2_amount'
  spec_attribute 'start_date', spec: 'date'
  spec_attribute 'end_date'  , spec: 'date'
  spec_attribute 'interval'  , spec: 'recurring_interval'
  spec_attribute 'expiring_notification_time'
  spec_attribute 'active'
  spec_attribute 'enabled'
end