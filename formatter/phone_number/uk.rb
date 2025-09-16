module Formatter
  module PhoneNumber
    module UK
      def self.format(phone_number = nil)
        normalized_phone_number = normalize(phone_number)
        validate(normalized_phone_number)
				
        "+44#{normalized_phone_number}"
      end

      private

      def self.validate(phone_number)
        raise Errors::BlankError if phone_number.nil? || phone_number == ''

        raise Errors::InvalidCharacters if phone_number.match(/[^0-9]/)

        raise Errors::InvalidLengthError if phone_number.length < 10
      end

      def self.normalize(phone_number)
        phone_number&.strip
          &.gsub(/\s/, '')
          &.gsub(/^(\+?44|0)/, '')
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