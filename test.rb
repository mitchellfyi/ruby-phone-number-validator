require 'minitest/autorun'
require_relative 'formatter/phone_number/uk'

class PhoneNumberFormatterTest < Minitest::Test
  def test_valid_phone_number_format
    result = Formatter::PhoneNumber::UK.format('071234 56789')
    assert_equal '+447123456789', result
  end

  def test_invalid_phone_nmber_format
    assert_raises StandardError do
      Formatter::PhoneNumber::UK.format('0634343')
    end
  end
end