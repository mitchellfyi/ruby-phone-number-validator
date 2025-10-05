require 'minitest/autorun'
require_relative 'formatter/phone_number/uk'

class PhoneNumberFormatterTest < Minitest::Test
  def test_valid_with_spaces
    result = Formatter::PhoneNumber::UK.format('071234 56789')
    assert_equal '+447123456789', result

    result = Formatter::PhoneNumber::UK.format(' 071 234 567 89 ')
    assert_equal '+447123456789', result

    result = Formatter::PhoneNumber::UK.format("071234\t56789")
    assert_equal '+447123456789', result
  end

  def test_normalized_and_valid_with_some_characters
    result = Formatter::PhoneNumber::UK.format('071234-56789')
    assert_equal '+447123456789', result

    result = Formatter::PhoneNumber::UK.format('071234.56789')
    assert_equal '+447123456789', result
  end

  def test_normalized_and_valid_integer
    result = Formatter::PhoneNumber::UK.format(7890123456)
    assert_equal '+447890123456', result
  end

  def test_valid_prefixes
    result = Formatter::PhoneNumber::UK.format('01234567890')
    assert_equal '+441234567890', result

    result = Formatter::PhoneNumber::UK.format('+441234567890')
    assert_equal '+441234567890', result

    result = Formatter::PhoneNumber::UK.format('441234567890')
    assert_equal '+441234567890', result

    result = Formatter::PhoneNumber::UK.format('4401234567890')
    assert_equal '+441234567890', result

    result = Formatter::PhoneNumber::UK.format('+447234567890')
    assert_equal '+447234567890', result
  end

  def test_invalid_length
    assert_raises Formatter::PhoneNumber::Errors::InvalidLengthError do
      Formatter::PhoneNumber::UK.format('0634343')
    end

    assert_raises Formatter::PhoneNumber::Errors::InvalidLengthError do
      Formatter::PhoneNumber::UK.format('0123456789')
    end

    assert_raises Formatter::PhoneNumber::Errors::InvalidLengthError do
      Formatter::PhoneNumber::UK.format('012345678901')
    end
  end

  def test_blank
    assert_raises Formatter::PhoneNumber::Errors::BlankError do
      Formatter::PhoneNumber::UK.format
    end

    assert_raises Formatter::PhoneNumber::Errors::BlankError do
      Formatter::PhoneNumber::UK.format(nil)
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