require 'minitest/autorun'
require_relative 'formatter/phone_number/uk'

class PhoneNumberFormatterTest < Minitest::Test
  def test_valid_with_spaces
    result = Formatter::PhoneNumber::UK.format('071234 56789')
    assert_equal '+447123456789', result

    result = Formatter::PhoneNumber::UK.format(' 071 234 567 89 ')
    assert_equal '+447123456789', result
  end

  def test_invalid_length
    assert_raises Formatter::PhoneNumber::Errors::InvalidLengthError do
      Formatter::PhoneNumber::UK.format('0634343')
    end

    assert_raises Formatter::PhoneNumber::Errors::InvalidLengthError do
      Formatter::PhoneNumber::UK.format('0123456789')
    end

    assert_raises Formatter::PhoneNumber::Errors::InvalidLengthError do
      puts Formatter::PhoneNumber::UK.format('012345678901')
    end
  end

  def test_blank
    assert_raises Formatter::PhoneNumber::Errors::BlankError do
      Formatter::PhoneNumber::UK.format
    end

    assert_raises Formatter::PhoneNumber::Errors::BlankError do
      Formatter::PhoneNumber::UK.format('')
    end

    assert_raises Formatter::PhoneNumber::Errors::BlankError do
      Formatter::PhoneNumber::UK.format(' ')
    end
  end

  def test_invalid_characters
    assert_raises Formatter::PhoneNumber::Errors::InvalidCharacters do
      Formatter::PhoneNumber::UK.format('+44712345678o')
    end
  end
  
end