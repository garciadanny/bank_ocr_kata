require_relative './glossary'

class OCR
  include Glossary

  attr_reader :document_path, :account_numbers, :results_path

  def self.parse_document(document_path, results_path = nil)
    instance = new(document_path, results_path)
    instance.parse_document
    instance
  end

  def initialize(document_path, results_path)
    @document_path = document_path
    @account_numbers = []
    @results_path = results_path
  end

  def parse_document
    File.open(document_path).each_slice(4) do |four_lines|
      num_string = ''
      account_number = ''
      sec1, sec2, sec3 = four_lines

      sec1.chomp!
      sec2.chomp!
      sec3.chomp!

      while sec1.length > 0
        num_string << sec1.slice!(0,3)
        num_string << sec2.slice!(0,3)
        num_string << sec3.slice!(0,3)
        account_number << account_digit_lookup(num_string)
        num_string = ''
      end
      @account_numbers << account_number
    end
  end

  def validated_account_numbers
    validated = Hash.new { |hash, key| hash[key] = [] }

    account_numbers.each do |account_number|
      validity = account_number_validity(account_number)
      validated[validity] << account_number
    end

    validated
  end

  def print_results
    File.open(results_path, 'w') do |f|
      validated_account_numbers.each do |validity, list|
        f.write account_number_results(validity, list)
      end
    end
  end

  def account_number_results(validity, list)
    case validity
    when :valid
      list.each { |number| number.concat("\n") }
    when :invalid
      list.each { |number| number.concat(" ERR\n") }
    else
      list.each { |number| number.concat(" ILL\n") }
    end.join("")
  end

  private def account_digit_lookup(number)
    digit = glossary[number]
    if digit.nil?
      "?"
    else
      digit
    end
  end

  private def account_number_validity(account_number)
    if account_number.include?("?")
      :illegible
    elsif valid_account_number?(account_number)
      :valid
    else
      :invalid
    end
  end

  private def valid_account_number?(account_number)
    nums = account_number.split('').map(&:to_i).reverse
    sum = 0
    nums.each_with_index do |num, index|
      sum += num * (index + 1)
    end

    sum % 11 == 0
  end
end

