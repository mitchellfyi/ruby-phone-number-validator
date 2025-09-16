module Formatter
  module PhoneNumber
    module UK
      COUNTRY_CODE = '+44'
      EXPECTED_LENGTH = 10

      WHITESPACE_REGEX = (/\s|\-|\./).freeze
      PREFIX_REGEX = (/^(\+440|440|44|\+44|0)/).freeze
      INVALID_CHARS_REGEX = (/[^0-9]/).freeze

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
        phone_number&.strip
          &.gsub(WHITESPACE_REGEX, '')
          &.gsub(PREFIX_REGEX, '')
      end

      def self.blank?(phone_number)
        phone_number.nil? || phone_number == ''
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