require './lib/ocr'

document_path = File.join(
  File.dirname(__FILE__),
  '../', 'spec/fixtures/use_case_03.txt'
)
results_path = File.join(
  File.dirname(__FILE__),
  "../results/results_#{Time.now.to_i}"
)

ocr = OCR.parse_document(document_path, results_path)
puts "Parsing document located in: #{document_path}..."

ocr.print_results
puts "Results saved to: #{results_path}."
