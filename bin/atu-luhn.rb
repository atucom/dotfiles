#!/usr/bin/env ruby
def credit_card_valid?(account_number) #stole this from some stackoverflow post (just google it)
  digits = account_number.scan(/./).map(&:to_i)
  check = digits.pop

  sum = digits.reverse.each_slice(2).map do |x, y|
    [(x * 2).divmod(10), y || 0]
  end.flatten.inject(:+)

  (10 - sum % 10) == check
end

def main()
  if ARGV.empty?
    puts "This script takes strings to check for LUHN"
    puts "\t Usage: #{$0} <CardNum> <CardNum>  ... "
else
    ARGV.each do |blah|
        if credit_card_valid?(blah)
          print "#{blah} : Valid\n"
        else
          print "#{blah} : Not Valid\n"
        end
    end
end
end
if __FILE__ == $0
  main
end