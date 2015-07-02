require 'rails_helper'

describe Services do
  describe '#[]' do
    let(:a_category) { :employment }
    subject { Services[a_category] }

    it { is_expected.to be_an Array }

    describe 'a member' do
      subject { super().first }

      it { is_expected.to be_a Hash }

      it 'has symbol keys' do
        subject.keys.each do |key|
          expect(key).to be_a Symbol
        end
      end

      describe '[:phone]' do
        subject { super()[:phone] }
        it { is_expected.to be_an Array }
      end

      describe '[:mailing_address]' do
        subject { super()[:mailing_address] }
        it { is_expected.to be_an Array }
      end

      describe '[:physical_address]' do
        subject { super()[:physical_address] }
        it { is_expected.to be_an Array }
      end
    end
  end
end
