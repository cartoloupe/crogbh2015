require 'rails_helper'

describe Service do
  # lets

  let(:description)      { '# Test Description' }
  let(:email)            { 'test@example.com' }
  let(:html_description) { "<h1>Test Description</h1>\n" }
  let(:mailing_address)  { 'PO Box 12345, Columbus, OH' }
  let(:phone)            { '1234567890' }
  let(:physical_address) { '2 Miranova Pl, Columbus, OH, 43215' }
  let(:title)            { 'Test Service' }
  let(:website)          { 'http://www.example.com' }

  # subject

  subject do
    Service.new(
      description:      description,
      email:            email,
      mailing_address:  mailing_address,
      phone:            phone,
      physical_address: physical_address,
      title:            title,
      website:          website,
    )
  end

  # tests

  describe '.title' do
    subject { super().title }

    it { is_expected.to eq title }
    it { is_expected.to be_frozen }
  end

  describe '.description' do
    subject { super().description }

    it { is_expected.to eq html_description }
    it { is_expected.to be_frozen }
  end

  describe '.mailing_address' do
    subject { super().mailing_address }

    it { is_expected.to be_an Array }
    it { is_expected.to be_frozen }
    it { is_expected.to match_array Array(mailing_address) }

    it "contains only frozen strings" do
      subject.each do |item|
        expect(item).to be_a String
        expect(item).to be_frozen
      end
    end
  end

  describe '.physical_address' do
    subject { super().physical_address }

    it { is_expected.to be_an Array }
    it { is_expected.to be_frozen }
    it { is_expected.to match_array Array(physical_address) }

    it "contains only frozen strings" do
      subject.each do |item|
        expect(item).to be_a String
        expect(item).to be_frozen
      end
    end
  end

  describe '.website' do
    subject { super().website }

    it { is_expected.to eq website }
    it { is_expected.to be_frozen }
  end

  describe '.email' do
    subject { super().email }

    it { is_expected.to eq email }
    it { is_expected.to be_frozen }
  end

  describe '.phone' do
    subject { super().phone }

    it { is_expected.to be_an Array }
    it { is_expected.to be_frozen }
    it { is_expected.to match_array Array(phone) }

    it "contains only frozen strings" do
      subject.each do |item|
        expect(item).to be_a String
        expect(item).to be_frozen
      end
    end
  end
end
