require 'rails_helper'

describe Services do
  # subject

  subject { described_class }

  # tests

  describe '#[]' do
    let(:a_category) { :employment }

    subject { super()[a_category] }

    it { is_expected.to be_a Category }
  end

  describe '#categories' do
    subject { super().categories }

    it { is_expected.to be_an Array }

    it 'is expected to be an Array containing only Category objects' do
      subject.each do |category|
        expect(category).to be_a Category
      end
    end
  end
end
