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
        raise StandardError, 'invalid' if phone_number.length < 11
      end

      def self.normalize(phone_number)
        clean_phone_number = phone_number.strip.gsub(/\s/, '').gsub(/^(\+?44|0)/, '')
      end
    end
  end
end