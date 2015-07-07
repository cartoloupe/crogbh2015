require 'rails_helper'

describe EndUserDetail do
  subject { create :end_user_detail }

  it { is_expected.to be_valid }

  context 'with a 5 digit zip code' do
    let(:zip) { '12345' }
    subject { create :end_user_detail, zip: zip }
    it { is_expected.to be_valid }
  end

  context 'with a 9 digit zip code' do
    let(:zip) { '123456789' }
    subject { create :end_user_detail, zip: zip }
    it { is_expected.to be_valid }
  end

  context 'with a zip code that is less than 5 digits' do
    let(:zip) { '1234' }
    subject { create :end_user_detail, zip: zip }
    it { is_expected.not_to be_valid }
  end

  context 'with a zip code that is in between 5 and 9 digits exclusive' do
    let(:zip) { '123456' }
    subject { create :end_user_detail, zip: zip }
    it { is_expected.not_to be_valid }
  end

  context 'with a zip code that is more than 9 digits' do
    let(:zip) { '1234567890' }
    subject { create :end_user_detail, zip: zip }
    it { is_expected.not_to be_valid }
  end

  context 'with a zip code that contains anything but digits' do
    let(:zip) { 'ab-_!' }
    subject { create :end_user_detail, zip: zip }
    it { is_expected.not_to be_valid }
  end

  context 'with a phone number that is less than 10 digits' do
    let(:phone_number) { '123456789' }
    subject { create :end_user_detail, phone_number: phone_number }
    it { is_expected.not_to be_valid }
  end

  context 'with a phone number that is more than 10 digits' do
    let(:phone_number) { '123456789' }
    subject { create :end_user_detail, phone_number: phone_number }
    it { is_expected.not_to be_valid }
  end

  context 'with a phone number that contains anything but digits' do
    let(:phone_number) { 'abc-_!def$' }
    subject { create :end_user_detail, phone_number: phone_number }
    it { is_expected.not_to be_valid }
  end

  context 'with a state abbreviation that is less than 2 chars' do
    let(:state) { 'A' }
    subject { create :end_user_detail, state: state }
    it { is_expected.not_to be_valid }
  end

  context 'with a state abbreviation that is more than 2 chars' do
    let(:state) { 'AAA' }
    subject { create :end_user_detail, state: state }
    it { is_expected.not_to be_valid }
  end

  context 'with a state abbreviation that contains anything but uppercase letters' do
    let(:state) { 'a1' }
    subject { create :end_user_detail, state: state }
    it { is_expected.not_to be_valid }
  end
end
