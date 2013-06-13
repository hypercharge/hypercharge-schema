require 'test_helper'


describe 'Reconcile JSON Schema' do
  let(:schema_path){ schema_path_for('reconcile') }
  subject{ fixture('reconcile') }
  let(:root_key){ subject.keys.first }

  root_wont_allow_additional_properties
  spec_attribute 'unique_id'
end