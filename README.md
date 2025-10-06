# Ruby Phone Number Validator

A Ruby gem for formatting and validating UK phone numbers. Converts various input formats to international format (+44...).

## Demo

<iframe width="560" height="315" src="https://www.youtube.com/embed/JGVfaos3wQM?si=VDGdpGkx4Q3zA9AH" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Features

- Formats UK phone numbers to international format (+44...)
- Handles multiple input formats: `07...`, `+44...`, `44...`, `0...`
- Removes spaces, dashes, dots, and parentheses
- Validates phone number length and characters
- Comprehensive error handling

## Usage

```ruby
require_relative 'formatter/phone_number/uk'

# Format various input formats
Formatter::PhoneNumber::UK.format('071234 56789')     # => '+447123456789'
Formatter::PhoneNumber::UK.format('+44 7123 456789')  # => '+447123456789'
Formatter::PhoneNumber::UK.format('447123456789')     # => '+447123456789'
```

## Testing

Run the test suite:

```bash
ruby test.rb
```

## Error Handling

The formatter raises specific errors for invalid inputs:
- `Formatter::PhoneNumber::Errors::BlankError` - for blank or nil inputs
- `Formatter::PhoneNumber::Errors::InvalidCharacters` - for non-numeric characters
- `Formatter::PhoneNumber::Errors::InvalidLengthError` - for incorrect length
