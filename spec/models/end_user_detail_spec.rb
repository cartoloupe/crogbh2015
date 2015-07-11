require 'rails_helper'

describe EndUserDetail do
  # shared contexts

  ## zip

  shared_context 'it has a valid zip code' do
    subject { build :end_user_detail, zip: zip }
    it { is_expected.to be_valid }
  end

  shared_context 'it has an invalid zip code' do
    subject { build :end_user_detail, zip: zip }
    it { is_expected.not_to be_valid }
  end

  ## phone

  shared_context 'it has a valid phone number' do
    subject { build :end_user_detail, phone: phone }
    it { is_expected.to be_valid }
  end

  shared_context 'it has an invalid phone number' do
    subject { build :end_user_detail, phone: phone }
    it { is_expected.not_to be_valid }
  end

  ## state

  shared_context 'it has a valid state' do
    subject { build :end_user_detail, state: state }
    it { is_expected.to be_valid }
  end

  shared_context 'it has an invalid state' do
    subject { build :end_user_detail, state: state }
    it { is_expected.not_to be_valid }
  end

  # subject

  subject { build :end_user_detail }

  # behaviors

  it_behaves_like 'a user detail model'

  # tests

  ## general

  it { is_expected.to respond_to :user }

  ## zip

  context 'with a blank zip code' do
    let(:zip) { '' }
    it_behaves_like 'it has a valid zip code'
  end

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

  ## phone number

  context 'with a blank phone number' do
    let(:phone) { '' }
    it_behaves_like 'it has a valid phone number'
  end

  context 'with a 10 digit phone number' do
    let(:phone) { '1234567890' }
    it_behaves_like 'it has a valid phone number'
  end

  context 'with a phone number that is less than 10 digits' do
    let(:phone) { '123456789' }
    it_behaves_like 'it has an invalid phone number'
  end

  context 'with a phone number that is more than 10 digits' do
    let(:phone) { '123456789' }
    it_behaves_like 'it has an invalid phone number'
  end

  context 'with a phone number that contains anything but digits' do
    let(:phone) { 'abc-_!def$' }
    it_behaves_like 'it has an invalid phone number'
  end

  ## state

  context 'with a blank state' do
    let(:state) { '' }
    it_behaves_like 'it has a valid state'
  end

  context 'with a 2 character uppercase state abbreviation' do
    let(:state) { 'AA' }
    it_behaves_like 'it has a valid state'
  end

  context 'with a state abbreviation that is 1 char' do
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
