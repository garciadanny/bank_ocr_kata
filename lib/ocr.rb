require_relative './glossary'
require 'pry'

class OCR
  include Glossary

  attr_reader :document_path, :account_numbers

  def self.parse_document(document_path)
    instance = new(document_path)
    instance.parse_document
    instance
  end

  def initialize(document_path)
    @document_path = document_path
    @account_numbers = []
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
        account_number << glossary[num_string]
        num_string = ''
      end
      @account_numbers << account_number
    end
  end

end
