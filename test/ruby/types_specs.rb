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
        subject[root_key]['billing_address']['notInSchema'] = 1
        validate(schema_path, subject).must_equal false
      end
    end

    it 'presence' do
      subject[root_key].delete('billing_address')
      validate(schema_path, subject).must_equal !required
    end

    it 'must be an object' do
      subject[root_key]['billing_address'] = 'no object'
      validate(schema_path, subject).must_equal false
    end

    describe 'first_name' do
      it 'must be present' do
        subject[root_key]['billing_address'].delete('first_name')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['billing_address']['first_name'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['billing_address']['first_name'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['first_name'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'last_name' do
      it 'must be present' do
        subject[root_key]['billing_address'].delete('last_name')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['billing_address']['last_name'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['billing_address']['last_name'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['last_name'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end


    describe 'address1' do
      it 'must be present' do
        subject[root_key]['billing_address'].delete('address1')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['billing_address']['address1'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['billing_address']['address1'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['address1'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'address2' do
      it 'is optional' do
        subject[root_key]['billing_address'].delete('address2')
        validate(schema_path, subject).must_equal true
      end

      it 'wont be empty' do
        subject[root_key]['billing_address']['address2'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['billing_address']['address2'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['address2'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'city' do
      it 'must be present' do
        subject[root_key]['billing_address'].delete('city')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['billing_address']['city'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 255' do
        subject[root_key]['billing_address']['city'] = 'a' * 255
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 255' do
        subject[root_key]['billing_address']['city'] = 'a' * 256
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'zip_code' do
      it 'must be present' do
        subject[root_key]['billing_address'].delete('zip_code')
        validate(schema_path, subject).must_equal false
      end

      it 'wont be empty' do
        subject[root_key]['billing_address']['zip_code'] = ''
        validate(schema_path, subject).must_equal false
      end

      it 'must allow size = 32' do
        subject[root_key]['billing_address']['zip_code'] = 'a' * 32
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow size > 32' do
        subject[root_key]['billing_address']['zip_code'] = 'a' * 33
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'state' do
      it 'is optional' do
        validate(schema_path, subject).must_equal true
      end

      it 'must allow ISO 3166_2 in USA' do
        subject[root_key]['billing_address']['state'] = 'CA'
        validate(schema_path, subject).must_equal true
      end

      it 'must allow ISO 3166_2 in Canada' do
        subject[root_key]['billing_address']['state'] = 'AB'
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow other' do
        subject[root_key]['billing_address']['state'] = 'XX'
        validate(schema_path, subject).must_equal false
      end
    end

    describe 'country' do
      it 'must be present' do
        subject[root_key]['billing_address'].delete('country')
        validate(schema_path, subject).must_equal false
      end

      it 'must allow US' do
        subject[root_key]['billing_address']['country'] = 'US'
        validate(schema_path, subject).must_equal true
      end

      it 'wont allow USA' do
        subject[root_key]['billing_address']['country'] = 'USA'
        validate(schema_path, subject).must_equal false
      end

      it 'wont allow XX' do
        subject[root_key]['billing_address']['country'] = 'XX'
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
      validate(schema_path, subject).must_equal false
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

  describe 'bank_account_number' do
    it 'must be present' do
      subject[root_key].delete('bank_account_number')
      validate(schema_path, subject).must_equal false
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
      validate(schema_path, subject).must_equal false
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

  describe 'date' do
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

    it 'wont allow impossible date' do
      subject['start_date'] = "2013-22-01"
      validate(schema_path, subject).must_equal false

      subject['start_date'] = "2013-01-41"
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

    it 'wont allow 0' do
      subject[attr_name] = 0
      validate(schema_path, subject).must_equal false
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

  describe 'enabled' do
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

    it 'must allow true' do
      subject[attr_name] = true
      validate(schema_path, subject).must_equal true
    end

    it 'must allow false' do
      subject[attr_name] = false
      validate(schema_path, subject).must_equal true
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
end
