# encoding: UTF-8
class TypesSpecs
  @@registry = {}
  def self.describe desc, &block
    @@registry[desc] = block
  end

  def self.proc_for(key)
    registry[key]
  end

  def self.registry
    @@registry
  end


  describe 'transaction_type' do
    it 'is a static string' do
      subject[root_key]['transaction_type'] = value
      validate(schema_path, subject).must_equal true
    end

    it 'is a present' do
      subject[root_key].delete('transaction_type')
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow nil' do
      subject[root_key]['transaction_type'] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow other string' do
      subject[root_key]['transaction_type'] = "#{value}nope"
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow integer' do
      subject[root_key]['transaction_type'] = 1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'type' do
    it 'is a static string' do
      subject[root_key]['type'] = value
      validate(schema_path, subject).must_equal true
    end

    it 'must be present' do
      subject[root_key].delete('type')
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow nil' do
      subject[root_key]['type'] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow other string' do
      subject[root_key]['type'] = "#{value}nope"
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow integer' do
      subject[root_key]['type'] = 1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'amount' do

    it 'must be present' do
      subject[root_key].delete('amount')
      validate(schema_path, subject).must_equal false
    end

    it 'must be an integer' do
      subject[root_key]['amount'] = 'one'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 0' do
      subject[root_key]['amount'] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow negaitive values' do
      subject[root_key]['amount'] = -1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'v2_amount' do

    it 'must be present' do
      subject.delete('amount')
      validate(schema_path, subject).must_equal !required
    end

    it 'must be an integer' do
      subject['amount'] = 'one'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 0' do
      subject['amount'] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow negaitive values' do
      subject['amount'] = -1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'currency' do
    it 'must be present' do
      subject[root_key].delete('currency')
      validate(schema_path, subject).must_equal false
    end

    it 'must be ISO 4217' do
      subject[root_key]['currency'] = 'Euros'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'transaction_id' do
    it 'must be present' do
      subject[root_key].delete('transaction_id')
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key]['transaction_id'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 1' do
      subject[root_key]['transaction_id'] = 'a'
      validate(schema_path, subject).must_equal true
    end

    it 'must allow size = 255' do
      subject[root_key]['transaction_id'] = 'a'* 255
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 255' do
      subject[root_key]['transaction_id'] = 'a'* 256
      validate(schema_path, subject).must_equal false
    end

    it 'must match pattern' do
      subject[root_key]['transaction_id'] = '%'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'usage' do
    it 'presence' do
      subject[root_key].delete('usage')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['usage'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 255' do
      subject[root_key]['usage'] = 'a' * 255
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 255' do
      subject[root_key]['usage'] = 'a' * 256
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'description' do
    it 'is required' do
      subject[root_key].delete('description')
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key]['description'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 1' do
      subject[root_key]['description'] = 'a'
      validate(schema_path, subject).must_equal true
    end

    it 'must allow size = 12400' do
      subject[root_key]['description'] = 'a' * 12400
      validate(schema_path, subject).must_equal true
    end
  end

  describe 'editable_by_user' do
    it 'is optional' do
      subject[root_key].delete('editable_by_user')
      validate(schema_path, subject).must_equal true
    end

    it 'wont be empty string' do
      subject[root_key]['editable_by_user'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'wont be integer' do
      subject[root_key]['editable_by_user'] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'must allow true' do
      subject[root_key]['editable_by_user'] = true
      validate(schema_path, subject).must_equal true
    end

    it 'must allow false' do
      subject[root_key]['editable_by_user'] = false
      validate(schema_path, subject).must_equal true
    end
  end

  describe 'customer_email' do
    # if required
    it 'presence' do
      subject[root_key].delete('customer_email')
      validate(schema_path, subject).must_equal !required
    end
    # else
    #   it 'must be present optional' do
    #     subject[root_key].delete('customer_email')
    #     validate(schema_path, subject).must_equal false
    #   end
    # end

    it 'must be an email address' do
      subject[root_key]['customer_email'] = 'this-is-no-email-address.com'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'customer_phone' do
    it 'is optional' do
      subject[root_key].delete('customer_phone')
      validate(schema_path, subject).must_equal true
    end

    it 'wont be empty' do
      subject[root_key]['customer_phone'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 255' do
      subject[root_key]['customer_phone'] = '0' * 255
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 255' do
      subject[root_key]['customer_phone'] = '0' * 256
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'url' do
    it 'must be present' do
      subject[root_key].delete(attr_name)
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key][attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow http' do
      subject[root_key][attr_name] = 'http://exmaple.com/notify'
      validate(schema_path, subject).must_equal true
    end

    it 'must allow https' do
      subject[root_key][attr_name] = 'https://exmaple.com/notify'
      validate(schema_path, subject).must_equal true
    end

    it 'must be a URL' do
      subject[root_key][attr_name] = 'This is no URL'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'billing_address' do
    describe 'the object' do
      it 'wont allow additionalProperties' do
        subject[root_key][attr_name]['notInSchema'] = 1
        validate(schema_path, subject).must_equal false
      end
    end

    it 'presence' do
      subject[root_key].delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'must be an object' do
      subject[root_key][attr_name] = 'no object'
      validate(schema_path, subject).must_equal false
    end

    describe 'first_name' do
      it 'must be present' do
        subject[root_key][attr_name].delete('first_name')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key][attr_name]['first_name'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key][attr_name]['first_name'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key][attr_name]['first_name'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'last_name' do
      it 'must be present' do
        subject[root_key][attr_name].delete('last_name')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key][attr_name]['last_name'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key][attr_name]['last_name'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key][attr_name]['last_name'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end


    describe 'address1' do
      it 'must be present' do
        subject[root_key][attr_name].delete('address1')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key][attr_name]['address1'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key][attr_name]['address1'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key][attr_name]['address1'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'address2' do
      it 'is optional' do
        subject[root_key][attr_name].delete('address2')
        validate(schema_path, subject).must_equal true
      end

      it 'wont be empty' do
        subject[root_key][attr_name]['address2'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key][attr_name]['address2'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key][attr_name]['address2'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'city' do
      it 'must be present' do
        subject[root_key][attr_name].delete('city')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key][attr_name]['city'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key][attr_name]['city'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key][attr_name]['city'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'zip_code' do
      it 'must be present' do
        subject[root_key][attr_name].delete('zip_code')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key][attr_name]['zip_code'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 32' do
        subject[root_key][attr_name]['zip_code'] = 'a' * 32
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 32' do
        subject[root_key][attr_name]['zip_code'] = 'a' * 33
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'state' do
      it 'is optional' do
        validate(schema_path, subject).must_equal true
      end

      it 'must allow ISO 3166_2 in USA' do
        subject[root_key][attr_name]['state'] = 'CA'
        validate(schema_path, subject).must_equal true
      end

      it 'must allow ISO 3166_2 in Canada' do
        subject[root_key][attr_name]['state'] = 'AB'
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow other' do
        subject[root_key][attr_name]['state'] = 'XX'
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'country' do
      it 'must be present' do
        subject[root_key][attr_name].delete('country')
        validate(schema_path, subject).must_equal false
      end

      it 'must allow US' do
        subject[root_key][attr_name]['country'] = 'US'
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow USA' do
        subject[root_key][attr_name]['country'] = 'USA'
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow XX' do
        subject[root_key][attr_name]['country'] = 'XX'
        validate(schema_path, subject).must_equal false
      end
    end

  end

  describe 'transaction_types' do
    it 'is optional' do
      subject[root_key].delete('transaction_types')
      validate(schema_path, subject).must_equal true
    end

    it 'must allow customer initiated payments_transaction types' do
      ['authorize', 'authorize3d', 'sale', 'sale3d', 'init_recurring_sale',
        'ideal_sale', 'debit_sale', 'sepa_debit', 'direct_pay24_sale',
        'giro_pay_sale', 'pay_safe_card_sale', 'init_recurring_authorize',
        'purchase_on_account', 'pay_in_advance', 'deposit', 'payment_on_delivery',
        'pay_pal', 'init_recurring_debit_sale', 'init_recurring_debit_authorize',
        'recurring_debit_sale', 'barzahlen_sale'].each do |tt|
          subject[root_key]['transaction_types'] = [tt]
          validate(schema_path, subject).must_equal true
      end
    end

    it 'wont allow arbitrary values' do
      subject[root_key]['transaction_types'] = ['NOPE']
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow empty array' do
      subject[root_key]['transaction_types'] = []
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow non array type' do
      subject[root_key]['transaction_types'] = 'not an array!'
      validate(schema_path, subject).must_equal false
    end
  end


  describe 'retries' do
    it 'is optional' do
      subject[root_key].delete('retries')
      validate(schema_path, subject).must_equal true
    end

    it 'wont be nil' do
      subject[root_key]['retries'] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'must be an integer' do
      subject[root_key]['retries'] = 'not an integer!'
      validate(schema_path, subject).must_equal false
    end

    it 'wont be 0' do
      subject[root_key]['retries'] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'must be postive' do
      subject[root_key]['retries'] = -1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'risk_params' do
    describe 'the object' do
      it 'wont allow additionalProperties' do
        subject[root_key]['risk_params']['notInSchema'] = 1
        validate(schema_path, subject).must_equal false
      end
    end

    it 'is optional' do
      subject[root_key].delete('risk_params')
      validate(schema_path, subject).must_equal true
    end

    it 'must allow the following known keys' do
      ['ssn', 'mac_address', 'session_id', 'user_id', 'user_level',
        'email', 'phone', 'remote_ip', 'serial_number', 'infocapture_token'].each do |tt|
        subject[root_key]['risk_params'] = {tt => 'a string'}
        validate(schema_path, subject).must_equal true
      end
    end

    it 'wont allow two keys in items' do
      subject[root_key]['risk_params'] = [{'ssn' => 'a string', 'user_level' => '1'}]
      validate(schema_path, subject).must_equal false
    end


    it 'wont allow arbitrary keys in items' do
      subject[root_key]['risk_params'] = {'NOPE' => 'a string'}
      validate(schema_path, subject).must_equal false
    end

    # TODO:
    # it 'wont allow empty object' do
    #   subject[root_key]['risk_params'] = {}
    #   validate(schema_path, subject).must_equal false
    # end

    it 'wont allow non object type' do
      subject[root_key]['risk_params'] = 'not an object!'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow array' do
      subject[root_key]['risk_params'] = ['not an object!']
      validate(schema_path, subject).must_equal false
    end

  end

  describe 'risk_params_birthday' do
    it 'must allow birthday' do
      sub = subject
      subject {subject[root_key]['risk_params']}
      MiniTest::Spec.spec_attribute 'birthday', spec: 'birth_date', required: required
      subject {sub}
    end
  end


  describe 'recurring_schedule' do
    it 'is optional' do
      subject[root_key].delete('recurring_schedule')
      validate(schema_path, subject).must_equal true
    end

    it 'must be an object' do
      subject[root_key]['recurring_schedule'] = "not an object!"
      validate(schema_path, subject).must_equal false
    end

    describe 'start_date' do
      it 'must be present' do
        subject[root_key]['recurring_schedule'].delete('start_date')
        validate(schema_path, subject).must_equal false
      end

      it 'must be a string' do
        subject[root_key]['recurring_schedule']['start_date'] = 1
        validate(schema_path, subject).must_equal false
      end

      it 'must allow date format YYYY-MM-DD' do
        subject[root_key]['recurring_schedule']['start_date'] = "2013-12-01"
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow other formats' do
        subject[root_key]['recurring_schedule']['start_date'] = "2013/12/01"
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow impossible date' do
        subject[root_key]['recurring_schedule']['start_date'] = "2013-22-01"
        validate(schema_path, subject).must_equal false

        subject[root_key]['recurring_schedule']['start_date'] = "2013-01-41"
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow arbitrary string' do
        subject[root_key]['recurring_schedule']['start_date'] = "not a date format"
        validate(schema_path, subject).must_equal false
      end

    end

    describe 'end_date' do
      it 'is optional' do
        subject[root_key]['recurring_schedule'].delete('end_date')
        validate(schema_path, subject).must_equal true
      end

      it 'must be a string' do
        subject[root_key]['recurring_schedule']['end_date'] = 1
        validate(schema_path, subject).must_equal false
      end

      it 'must allow date format YYYY-MM-DD' do
        subject[root_key]['recurring_schedule']['end_date'] = "2013-12-01"
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow other formats' do
        subject[root_key]['recurring_schedule']['end_date'] = "2013/12/01"
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow impossible date' do
        subject[root_key]['recurring_schedule']['end_date'] = "2013-22-01"
        validate(schema_path, subject).must_equal false

        subject[root_key]['recurring_schedule']['end_date'] = "2013-01-41"
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow arbitrary string' do
        subject[root_key]['recurring_schedule']['end_date'] = "not a date format"
        validate(schema_path, subject).must_equal false
      end

    end

    describe 'amount' do
      it 'must be present' do
        subject[root_key]['recurring_schedule'].delete('amount')
        validate(schema_path, subject).must_equal false
      end

      it 'must validate amount is integer' do
        subject[root_key]['recurring_schedule']['amount'] = 'not an integer'
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow 0' do
        subject[root_key]['recurring_schedule']['amount'] = 0
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow negaitive' do
        subject[root_key]['recurring_schedule']['amount'] = -1
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'interval' do
      it 'must be present' do
        subject[root_key]['recurring_schedule'].delete('interval')
        validate(schema_path, subject).must_equal false
      end

      it 'must allow "weekly", "monthly", "anually"' do
        ["weekly", "monthly", "anually"].each do |interval|
          subject[root_key]['recurring_schedule']['interval'] = interval
          validate(schema_path, subject).must_equal true
        end
      end

      it 'wont allow other values' do
        subject[root_key]['recurring_schedule']['interval'] = 'once'
        validate(schema_path, subject).must_equal false

        subject[root_key]['recurring_schedule']['interval'] =  1
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'max_retries' do
      it 'is optional' do
        subject[root_key]['recurring_schedule'].delete('max_retries')
        validate(schema_path, subject).must_equal true
      end

      it 'wont be nil' do
        subject[root_key]['recurring_schedule']['max_retries'] = nil
        validate(schema_path, subject).must_equal false
      end

      it 'must allow 0' do
        subject[root_key]['recurring_schedule']['max_retries'] = 0
        validate(schema_path, subject).must_equal true
      end

      it 'must allow 10' do
        subject[root_key]['recurring_schedule']['max_retries'] = 10
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow 11' do
        subject[root_key]['recurring_schedule']['max_retries'] = 11
        validate(schema_path, subject).must_equal false
      end

      it 'must be postive' do
        subject[root_key]['recurring_schedule']['max_retries'] = -1
        validate(schema_path, subject).must_equal false
      end
    end
  end

  describe 'remote_ip' do
    it 'presence' do
      subject[root_key].delete('remote_ip')
      validate(schema_path, subject).must_equal !required
    end

    it 'must allow 0.0.0.0' do
      subject[root_key]['remote_ip'] = '0.0.0.0'
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 255.255.255.255' do
      subject[root_key]['remote_ip'] = '255.255.255.255'
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow partial' do
      subject[root_key]['remote_ip'] = '255.255.255'
      validate(schema_path, subject).must_equal false
    end

    it 'wont arbitrary string' do
      subject[root_key]['remote_ip'] = 'nope an ip'
      validate(schema_path, subject).must_equal false
    end

    it 'wont integer' do
      subject[root_key]['remote_ip'] = 1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'card_holder' do
    it 'must be present' do
      subject[root_key].delete('card_holder')
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key]['card_holder'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 255' do
      subject[root_key]['card_holder'] = 'a' * 255
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 255' do
      subject[root_key]['card_holder'] = 'a' * 256
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'card_number' do
    it 'must be present' do
      subject[root_key].delete('card_number')
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key]['card_number'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 13 digits' do
      subject[root_key]['card_number'] = "1" * 13
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 16 digits' do
      subject[root_key]['card_number'] = '1' * 16
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 12 digits' do
      subject[root_key]['card_number'] = '1' * 12
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 17 digits' do
      subject[root_key]['card_number'] = '1' * 17
      validate(schema_path, subject).must_equal false
    end

    it 'wont arbitrary string' do
      subject[root_key]['card_number'] = 'nope an ip'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'cvv' do
    it 'presence' do
      subject[root_key].delete('cvv')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['cvv'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 3 digits' do
      subject[root_key]['cvv'] = "1" * 3
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 4 digits' do
      subject[root_key]['cvv'] = '1' * 4
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 2 digits' do
      subject[root_key]['cvv'] = '1' * 2
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 5 digits' do
      subject[root_key]['cvv'] = '1' * 5
      validate(schema_path, subject).must_equal false
    end

    it 'wont arbitrary string' do
      subject[root_key]['cvv'] = 'nope an ip'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'expiration_month' do
    it 'must be present' do
      subject[root_key].delete('expiration_month')
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key]['expiration_month'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 2 digits' do
      subject[root_key]['expiration_month'] = "03"
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 1 digits' do
      subject[root_key]['expiration_month'] = '1'
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 13' do
      subject[root_key]['expiration_month'] = '13'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 20' do
      subject[root_key]['expiration_month'] = '20'
      validate(schema_path, subject).must_equal false
    end

    it 'wont arbitrary string' do
      subject[root_key]['expiration_month'] = 'nope an ip'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'expiration_year' do
    it 'must be present' do
      subject[root_key].delete('expiration_year')
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key]['expiration_year'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 4 digits' do
      subject[root_key]['expiration_year'] = "2013"
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 3 digits' do
      subject[root_key]['card_number'] = '013'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 5' do
      subject[root_key]['card_number'] = '20130'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow  < 2000' do
      subject[root_key]['card_number'] = '1999'
      validate(schema_path, subject).must_equal false
    end

    it 'wont arbitrary string' do
      subject[root_key]['card_number'] = 'nope an ip'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'mpi_params' do
   describe 'the object' do
      it 'wont allow additionalProperties' do
        subject[root_key]['mpi_params']['notInSchema'] = 1
        validate(schema_path, subject).must_equal false
      end
    end

    it 'must be present' do
      subject[root_key].delete('mpi_params')
      validate(schema_path, subject).must_equal false
    end

    describe 'cavv' do
      it 'must be present' do
        subject[root_key]['mpi_params'].delete('cavv')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['mpi_params']['cavv'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['mpi_params']['cavv'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['cavv'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'eci' do
      it 'must be present' do
        subject[root_key]['mpi_params'].delete('eci')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['mpi_params']['eci'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['mpi_params']['eci'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['eci'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'xid' do
      it 'must be present' do
        subject[root_key]['mpi_params'].delete('xid')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['mpi_params']['xid'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['mpi_params']['xid'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['xid'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end
  end

  describe 'wire_reference_id' do
    it 'is optional' do
      subject[root_key].delete('xid')
      validate(schema_path, subject).must_equal true
    end

    it 'wont be empty' do
      subject[root_key]['wire_reference_id'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 10' do
      subject[root_key]['wire_reference_id'] = 'a' * 10
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 10' do
      subject[root_key]['wire_reference_id'] = 'a' * 11
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'bank_account_holder' do
    it 'must be present' do
      subject[root_key].delete('bank_account_holder')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['bank_account_holder'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 255' do
      subject[root_key]['bank_account_holder'] = 'a' * 255
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 255' do
      subject[root_key]['bank_account_holder'] = 'a' * 256
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'bank_name' do
    it 'must be present' do
      subject[root_key].delete('bank_name')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['bank_name'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow values' do
      banks = ["ABN_AMRO", "POSTBANK", "RABOBANK", "FORTIS", "FORTIS_TEST", "SNS_BANK"]
      banks.each{|bank|
        subject[root_key]['bank_name'] = bank
        validate(schema_path, subject).must_equal true, "bank: #{bank}"
      }
    end

    it 'wont allow other value' do
      subject[root_key]['bank_name'] = 'WRONG_BANK'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'bank_account_number' do
    it 'must be present' do
      subject[root_key].delete('bank_account_number')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['bank_account_number'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 16' do
      subject[root_key]['bank_account_number'] = 'a' * 16
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 16' do
      subject[root_key]['bank_account_number'] = 'a' * 17
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'bank_number' do
    it 'must be present' do
      subject[root_key].delete('bank_number')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['bank_number'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 16' do
      subject[root_key]['bank_number'] = 'a' * 16
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 16' do
      subject[root_key]['bank_number'] = 'a' * 17
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'iban' do
    it 'must be present' do
      subject[root_key].delete('iban')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['iban'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow examples' do
      # http://www.rbs.co.uk/corporate/international/g0/guide-to-international-business/regulatory-information/iban/iban-example.ashx
      ibans = {
        'Albania' => 'AL47 2121 1009 0000 0002 3569 8741',
        'Andorra' => 'AD12 0001 2030 2003 5910 0100',
        'Austria' => 'AT61 1904 3002 3457 3201',
        'Azerbaijan' => 'AZ21 NABZ 0000 0000 1370 1000 1944',
        'Bahrain' => 'BH67 BMAG 0000 1299 1234 56',
        'Belgium' => 'BE62 5100 0754 7061',
        'Bosnia and Herzegovina' => 'BA39 1290 0794 0102 8494',
        'Bulgaria' => 'BG80 BNBG 9661 1020 3456 78',
        'Croatia' => 'HR12 1001 0051 8630 0016 0',
        'Cyprus' => 'CY17 0020 0128 0000 0012 0052 7600',
        'Czech Republic' => 'CZ65 0800 0000 1920 0014 5399',
        'Denmark' => 'DK50 0040 0440 1162 43',
        'Estonia' => 'EE38 2200 2210 2014 5685',
        'Faroe Islands' => 'FO97 5432 0388 8999 44',
        'Finland' => 'FI21 1234 5600 0007 85',
        'France' => 'FR14 2004 1010 0505 0001 3M02 606',
        'Georgia' => 'GE29 NB00 0000 0101 9049 17',
        'Germany' => 'DE89 3704 0044 0532 0130 00',
        'Gibraltar' => 'GI75 NWBK 0000 0000 7099 453',
        'Greece' => 'GR16 0110 1250 0000 0001 2300 695',
        'Greenland' => 'GL56 0444 9876 5432 10',
        'Hungary' => 'HU42 1177 3016 1111 1018 0000 0000',
        'Iceland' => 'IS14 0159 2600 7654 5510 7303 39',
        'Ireland' => 'IE29 AIBK 9311 5212 3456 78',
        'Israel' => 'IL62 0108 0000 0009 9999 999',
        'Italy' => 'IT40 S054 2811 1010 0000 0123 456',
        'Jordan' => 'JO94 CBJO 0010 0000 0000 0131 0003 02',
        'Kuwait' => 'KW81 CBKU 0000 0000 0000 1234 5601 01',
        'Latvia' => 'LV80 BANK 0000 4351 9500 1',
        'Lebanon' => 'LB62 0999 0000 0001 0019 0122 9114',
        'Liechtenstein' => 'LI21 0881 0000 2324 013A A',
        'Lithuania' => 'LT12 1000 0111 0100 1000',
        'Luxembourg' => 'LU28 0019 4006 4475 0000',
        'Macedonia' => 'MK072 5012 0000 0589 84',
        'Malta' => 'MT84 MALT 0110 0001 2345 MTLC AST0 01S',
        'Mauritius' => 'MU17 BOMM 0101 1010 3030 0200 000M UR',
        'Moldova' => 'MD24 AG00 0225 1000 1310 4168',
        'Monaco' => 'MC93 2005 2222 1001 1223 3M44 555',
        'Montenegro' => 'ME25 5050 0001 2345 6789 51',
        'Netherlands' => 'NL39 RABO 0300 0652 64',
        'Norway' => 'NO93 8601 1117 947',
        'Pakistan' => 'PK36 SCBL 0000 0011 2345 6702',
        'Poland' => 'PL60 1020 1026 0000 0422 7020 1111',
        'Portugal' => 'PT50 0002 0123 1234 5678 9015 4',
        'Qatar' => 'QA58 DOHB 0000 1234 5678 90AB CDEF G',
        'Romania' => 'RO49 AAAA 1B31 0075 9384 0000',
        'San Marino' => 'SM86 U032 2509 8000 0000 0270 100',
        'Saudi Arabia' => 'SA03 8000 0000 6080 1016 7519',
        'Serbia' => 'RS35 2600 0560 1001 6113 79',
        'Slovak Republic' => 'SK31 1200 0000 1987 4263 7541',
        'Slovenia' => 'SI56 1910 0000 0123 438',
        'Spain' => 'ES80 2310 0001 1800 0001 2345',
        'Sweden' => 'SE35 5000 0000 0549 1000 0003',
        'Switzerland' => 'CH93 0076 2011 6238 5295 7',
        'Tunisia' => 'TN59 1000 6035 1835 9847 8831',
        'Turkey' => 'TR33 0006 1005 1978 6457 8413 26',
        'UAE' => 'AE07 0331 2345 6789 0123 456',
        'United Kingdom' => 'GB29 RBOS 6016 1331 9268 19'
      }

      ibans.each{|country, iban|
        # stripped iban!
        iban = iban.gsub ' ', ''
        subject[root_key]['iban'] = iban
        validate(schema_path, subject).must_equal true, "'#{country}' iban: #{iban}"
      }
    end

    it 'wont allow size < 15' do
      subject[root_key]['iban'] = 'NO938601111794'
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 31' do
      subject[root_key]['iban'] = 'MU17BOMM0101101030300200000MUR1'
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 31' do
      subject[root_key]['iban'] = 'MU17BOMM0101101030300200000MUR12'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'bic' do
    it 'must be present' do
      subject[root_key].delete('bic')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['bic'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow examples' do
      bics = {
      'Natwest Offshore Bank - GB' => 'RBOSGGSX',
      'Raiffeisenbank Kitzbühel - Austria' => 'RZTIAT22263',
      "Banque et Caisse d'Epargne de l'Etat - Luxemburg" => 'BCEELULL',
      'Deutschen Bundesbank - Germany' => 'MARKDEFF',
      'Volksbank Jever - Germany' => 'GENODEF1JEV',
      'UBS AG - Switzerland' => 'UBSWCHZH80A',
      'Clearstream Banking - S.A., Luxembourg' => 'CEDELULLXXX'
      }

      bics.each{|bank, bic|
        subject[root_key]['bic'] = bic
        validate(schema_path, subject).must_equal true, "'#{bank}' bic: #{bic}"
      }
    end

    it 'wont allow size < 8' do
      subject[root_key]['bic'] = 'UBSWCHZ'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow size > 11' do
      subject[root_key]['bic'] = 'UBSWCHZH80A2'
      validate(schema_path, subject).must_equal false
    end
  end

  # sepa_mandate_id is NOT sepa creditor ID
  # sepa_mandate_id is a customer id defined by merchant.
  describe 'sepa_mandate_id' do
    it 'must be present' do
      subject[root_key].delete('sepa_mandate_id')
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key]['sepa_mandate_id'] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow size > 35' do
      subject[root_key]['bic'] = '0234567890abcdefghij0123456789abcdef'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'unique_id' do
    it 'must be present' do
      subject[root_key].delete(attr_name)
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[root_key][attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 32 length hex lowercase' do
      subject[root_key][attr_name] = '71818fe4f7d74531afc9bf7db801c221'
      validate(schema_path, subject).must_equal true
    end


    it 'wont allow 31 length hex lowercase' do
      subject[root_key][attr_name] = '71818fe4f7d74531afc9bf7db801c22'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 33 length hex lowercase' do
      subject[root_key][attr_name] = '71818fe4f7d74531afc9bf7db801c2211'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 32 non hex lowercase' do
      subject[root_key][attr_name] = '71818ge4f7d74531afc9bf7db801c221'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 32 length hex uppercase' do
      subject[root_key][attr_name] = '71818FE4F7D74531AFC9BF7DB801C221'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'birth_date' do
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'wont be nil' do
      subject[attr_name] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 2013-8-1' do
      subject[attr_name] = '2013-8-1'
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 1900-01-01' do
      subject[attr_name] = '1900-01-01'
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 1999-12-31' do
      subject[attr_name] = '1999-12-31'
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 2013-08-01' do
      subject[attr_name] = '2013-08-01'
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow other formats' do
      subject[attr_name] = "2013/12/01"
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow "may 12 2013"' do
      subject[attr_name] = 'may 12 2013'
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'company_name' do
    it 'must be present' do
      subject[root_key].delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[root_key][attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow size = 1' do
      subject[root_key][attr_name] = 'a'
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size = 255' do
      subject[root_key][attr_name] = 'a' * 255
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow size > 255' do
      subject[root_key][attr_name] = 'a' * 256
      validate(schema_path, subject).must_equal false
    end
  end
  #
  # v2 struct from here on
  #
  describe 'v2_unique_id' do
    it 'must be present' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal false
    end

    it 'wont be empty' do
      subject[attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 32 length hex lowercase' do
      subject[attr_name] = '71818fe4f7d74531afc9bf7db801c221'
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 31 length hex lowercase' do
      subject[attr_name] = '71818fe4f7d74531afc9bf7db801c22'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 33 length hex lowercase' do
      subject[attr_name] = '71818fe4f7d74531afc9bf7db801c2211'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 32 non hex lowercase' do
      subject[attr_name] = '71818ge4f7d74531afc9bf7db801c221'
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 32 length hex uppercase' do
      subject[attr_name] = '71818FE4F7D74531AFC9BF7DB801C221'
      validate(schema_path, subject).must_equal false
    end
  end

  # handles v1 and v2 struc
  describe 'date' do
    it 'presence' do
      if methods.include? :root_key
        subject[root_key].delete(attr_name)
      else
        subject.delete(attr_name)
      end
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      val = ''
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end

    it 'wont be nil' do
      val = nil
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 2013-8-1' do
      val = '2013-8-1'
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 1999-12-31' do
      val = '1999-12-31'
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 2101-01-01' do
      val = '2101-01-01'
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 2013-08-01' do
      val = '2013-08-01'
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 2023-12-31' do
      val = '2023-12-31'
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow other formats' do
      val = "2013/12/01"
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow "may 12 2013"' do
      val = 'may 12 2013'
      if methods.include? :root_key
        subject[root_key][attr_name] = val
      else
        subject[attr_name] = val
      end
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'expiring_notification_time' do
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'wont be nil' do
      subject[attr_name] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 0' do
      subject[attr_name] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 1' do
      subject[attr_name] = 1
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 100' do
      subject[attr_name] = 100
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 101' do
      subject[attr_name] = 101
      validate(schema_path, subject).must_equal false
    end

    it 'must be postive' do
      subject[attr_name] = -1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'active' do
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'wont be nil' do
      subject[attr_name] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 0' do
      subject[attr_name] = 0
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 1' do
      subject[attr_name] = 1
      validate(schema_path, subject).must_equal true
    end

    it 'must allow true' do
      subject[attr_name] = true
      validate(schema_path, subject).must_equal true
    end

    it 'must allow false' do
      subject[attr_name] = false
      validate(schema_path, subject).must_equal true
    end
  end

  describe 'boolean' do
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont be empty' do
      subject[attr_name] = ''
      validate(schema_path, subject).must_equal false
    end

    it 'wont be nil' do
      subject[attr_name] = nil
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 0' do
      subject[attr_name] = 0
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 1' do
      subject[attr_name] = 1
      validate(schema_path, subject).must_equal true
    end

    it 'must allow true' do
      subject[attr_name] = true
      validate(schema_path, subject).must_equal true
    end

    it 'must allow false' do
      subject[attr_name] = false
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow "true"' do
      subject[attr_name] = "true"
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'recurring_interval' do
    # code dublication with 'recurring_schedule.interval' because v1 and v2 mix
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'must allow "weekly", "monthly", "anually"' do
      ["weekly", "monthly", "anually"].each do |interval|
        subject[attr_name] = interval
        validate(schema_path, subject).must_equal true
      end
    end

    it 'wont allow other values' do
      subject[attr_name] = 'once'
      validate(schema_path, subject).must_equal false

      subject[attr_name] =  1
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'page' do
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont allow -1' do
      subject[attr_name] = -1
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 0' do
      subject[attr_name] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 1' do
      subject[attr_name] = 1
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 100000' do
      subject[attr_name] = 100000
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 100001' do
      subject[attr_name] = 100001
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow "1"' do
      subject[attr_name] = "1"
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow ""' do
      subject[attr_name] = ""
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow "foo"' do
      subject[attr_name] = "foo"
      validate(schema_path, subject).must_equal false
    end
  end

  describe 'per_page' do
    it 'presence' do
      subject.delete(attr_name)
      validate(schema_path, subject).must_equal !required
    end

    it 'wont allow -1' do
      subject[attr_name] = -1
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow 0' do
      subject[attr_name] = 0
      validate(schema_path, subject).must_equal false
    end

    it 'must allow 1' do
      subject[attr_name] = 1
      validate(schema_path, subject).must_equal true
    end

    it 'must allow 1000' do
      subject[attr_name] = 1000
      validate(schema_path, subject).must_equal true
    end

    it 'wont allow 1001' do
      subject[attr_name] = 1001
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow "1"' do
      subject[attr_name] = "1"
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow ""' do
      subject[attr_name] = ""
      validate(schema_path, subject).must_equal false
    end

    it 'wont allow "foo"' do
      subject[attr_name] = "foo"
      validate(schema_path, subject).must_equal false
    end
  end
end
