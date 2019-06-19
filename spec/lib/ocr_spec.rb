require_relative '../../lib/ocr'

describe OCR do
  describe '#parse_document' do
    context 'given a document with a valid account number of all 0s' do
      let(:path) { document_path('account_number_000000000.txt') }
      
      it 'should return a list of the parsed account numbers' do
        ocr = OCR.parse_document(path)
        expect(ocr.account_numbers).to eq ['000000000']
      end
    end

    context 'given a document with a valid account number of all 1s' do
      let(:path) { document_path('account_number_111111111.txt') }
      
      it 'should return a list of the parsed account numbers' do
        ocr = OCR.parse_document(path)
        expect(ocr.account_numbers).to eq ['111111111']
      end
    end

    context 'given a document with a valid account number ranging from 1-9' do
      let(:path) { document_path('account_number_123456789.txt') }
      
      it 'should return a list of the parsed account numbers' do
        ocr = OCR.parse_document(path)
        expect(ocr.account_numbers).to eq ['123456789']
      end
    end
  end
end
