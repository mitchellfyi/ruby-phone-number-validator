# UK Phone Number Formatter
# 
# This module provides functionality to format and validate UK phone numbers.
# It handles various input formats and normalizes them to international format (+44...).
#
# Supported formats:
# - Mobile numbers: 07xxxxxxxxx
# - Landline numbers: 01xxxxxxxxx, 02xxxxxxxxx, etc.
# - International format: +44xxxxxxxxx
# - With various separators: spaces, dashes, dots, parentheses
#
# Example usage:
#   Formatter::PhoneNumber::UK.format('07123 456789')  # => '+447123456789'
#   Formatter::PhoneNumber::UK.format('+44 7123 456789')  # => '+447123456789'
#
module Formatter
  module PhoneNumber
    module UK
      COUNTRY_CODE = '+44'
      EXPECTED_LENGTH = 10

      # Regex patterns for phone number processing
      WHITESPACE_REGEX = /[\s\-\.\(\)]/.freeze
      PREFIX_REGEX = /^(\+440|440|44|\+44|0)/.freeze
      INVALID_CHARS_REGEX = /[^0-9]/.freeze

      # Formats a UK phone number to international format (+44...)
      #
      # @param phone_number [String, Integer, nil] The phone number to format
      # @return [String] The formatted phone number in international format
      # @raise [Errors::BlankError] if phone number is blank or nil
      # @raise [Errors::InvalidCharacters] if phone number contains non-numeric characters
      # @raise [Errors::InvalidLengthError] if phone number is wrong length
      def self.format(phone_number = nil)
        normalized_phone_number = normalize(phone_number)
        validate(normalized_phone_number)

        "#{COUNTRY_CODE}#{normalized_phone_number}"
      end

      private

      def self.validate(phone_number)
        raise Errors::BlankError, 'Phone number cannot be blank' if blank?(phone_number)

        raise Errors::InvalidCharacters, 'Phone number must contain numbers only' if invalid_characters?(phone_number)

        raise Errors::InvalidLengthError, 'Phone number is the incorrect length' if invalid_length?(phone_number)
      end

      def self.normalize(phone_number)
        return '' if phone_number.nil?
        
        phone_number.to_s.strip
          .gsub(WHITESPACE_REGEX, '')
          .gsub(PREFIX_REGEX, '')
      end

      def self.blank?(phone_number)
        phone_number.nil? || phone_number.to_s.strip.empty?
      end

      def self.invalid_characters?(phone_number)
        phone_number.match(INVALID_CHARS_REGEX)
      end

      def self.invalid_length?(phone_number)
        phone_number.length != EXPECTED_LENGTH
      end
    end

    module Errors
      class Error < StandardError; end
  
      class InvalidLengthError < Error; end
      class BlankError < Error; end
      class InvalidCharacters < Error; end
    end
  end
end