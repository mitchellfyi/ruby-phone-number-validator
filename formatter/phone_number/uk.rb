module Formatter
  module PhoneNumber
    module UK
      def self.format(phone_number)
        validate(phone_number)
        normalized_phone_number = normalize(phone_number)
				
        "+44#{normalized_phone_number}"
      end

      private

      def self.validate(phone_number)
        raise Formatter::PhoneNumber::Errors::InvalidLengthError if phone_number.length < 11
      end

      def self.normalize(phone_number)
        phone_number.strip.gsub(/\s/, '').gsub(/^(\+?44|0)/, '')
      end
    end

    module Errors
      class InvalidLengthError < StandardError; end
    end
  end
end