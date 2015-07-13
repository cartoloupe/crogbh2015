require 'rails_helper'

describe Category do
  # lets

  let(:expected_key)  { key.to_sym }
  let(:expected_name) { 'This Is A Test' }
  let(:key)           { 'this-is-a-test' }

  let(:data) { [ { name: 'Test' } ] }

  # subject

  subject { Category.new key, data }

  # tests

  describe '.key' do
    subject { super().key }
    it { is_expected.to be_a Symbol }
    it { is_expected.to eq expected_key }
  end

  describe '.name' do
    subject { super().name }
    it { is_expected.to be_a String }
    it { is_expected.to eq expected_name }
    it { is_expected.to be_frozen }
  end

  describe '.services' do
    subject { super().services }

    it { is_expected.to be_an Array }

    it "only contains Service objects" do
      subject.each do |service|
        expect(service).to be_a Service
      end
    end
  end
end
