#!/usr/bin/env ruby

module SOACSV2MT940
  ##
  # Represents the financial amount of a given number
  class Amount
    # The amount which needs to be financially represented.
    # The format is either numeric or a string with a comma as decimal-point (Germany) and an optional negative sign: "-9,99".
    attr_accessor :amount

    ##
    # Creates a new Amount instance from the given number
    def initialize(number)
      @amount = if number.is_a? String
                  number.tr(',', '.').to_f
                else
                  number
                end
    end

    ##
    # Returns the credit / debit indicator for the amount
    def credit_debit_indicator
      if amount > 0
        'C'
      else
        'D'
      end
    end

    ##
    # Returns the string representation of an amount instance.
    def to_s
      format('%#.2f', amount).to_s.tr('.', ',')
    end

    ##
    # Returns the string representation of an amount instance without leading sign.
    def without_sign
      to_s.delete('-')
    end
  end
end
