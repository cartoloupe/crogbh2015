require 'rails_helper'

describe EndUserDetail do
  # shared contexts

  shared_context 'it has a valid zip code' do
    subject { create :end_user_detail, zip: zip }
    it { is_expected.to be_valid }
  end

  shared_context 'it has an invalid zip code' do
    subject { create :end_user_detail, zip: zip }
    it { is_expected.not_to be_valid }
  end

  shared_context 'it has an invalid phone number' do
    subject { create :end_user_detail, phone: phone }
    it { is_expected.not_to be_valid }
  end

  shared_context 'it has an invalid state' do
    subject { create :end_user_detail, state: state }
    it { is_expected.not_to be_valid }
  end

  # tests

  # not necessary because FactoryGirl ensures the factory creates a valid instance
  # it { is_expected.to be_valid }

  context 'with a 5 digit zip code' do
    let(:zip) { '12345' }
    it_behaves_like 'it has a valid zip code'
  end

  context 'with a 9 digit zip code' do
    let(:zip) { '123456789' }
    it_behaves_like 'it has a valid zip code'
  end

  context 'with a zip code that is less than 5 digits' do
    let(:zip) { '1234' }
    it_behaves_like 'it has an invalid zip code'
  end

  context 'with a zip code that is in between 5 and 9 digits exclusive' do
    let(:zip) { '123456' }
    it_behaves_like 'it has an invalid zip code'
  end

  context 'with a zip code that is more than 9 digits' do
    let(:zip) { '1234567890' }
    it_behaves_like 'it has an invalid zip code'
  end

  context 'with a zip code that contains anything but digits' do
    let(:zip) { 'ab-_!' }
    it_behaves_like 'it has an invalid zip code'
  end

  context 'with a phone number that is less than 10 digits' do
    let(:phone_number) { '123456789' }
    it_behaves_like 'it has an invalid phone number'
  end

  context 'with a phone number that is more than 10 digits' do
    let(:phone_number) { '123456789' }
    it_behaves_like 'it has an invalid phone number'
  end

  context 'with a phone number that contains anything but digits' do
    let(:phone_number) { 'abc-_!def$' }
    it_behaves_like 'it has an invalid phone number'
  end

  context 'with a state abbreviation that is less than 2 chars' do
    let(:state) { 'A' }
    it_behaves_like 'it has an invalid state'
  end

  context 'with a state abbreviation that is more than 2 chars' do
    let(:state) { 'AAA' }
    it_behaves_like 'it has an invalid state'
  end

  context 'with a state abbreviation that contains anything but uppercase letters' do
    let(:state) { 'a1' }
    it_behaves_like 'it has an invalid state'
  end
end
