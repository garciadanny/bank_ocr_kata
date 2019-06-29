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

  describe '#validated_account_numbers' do
    let(:path) { document_path('use_case_03.txt')  }

    context 'given invalid account numbers' do
      it 'returns a list of validated account_numbers' do
        ocr = OCR.parse_document(path)
        validated = ocr.validated_account_numbers

        expect(validated[:invalid]).to eq ['111111111']
      end
    end

    context 'given a list of valid account numbers' do
      it 'returns a list of validated account numbers' do
        ocr = OCR.parse_document(path)
        validated = ocr.validated_account_numbers

        expect(validated[:valid]).to eq ['000000051']
      end
    end

    context 'given a list with illegible account_numbers' do
      it 'returns a list of validated account numbers' do
        ocr = OCR.parse_document(path)
        validated = ocr.validated_account_numbers

        expect(validated[:illegible]).to eq ["49006771?", "1234?678?"]
      end
    end
  end
end
