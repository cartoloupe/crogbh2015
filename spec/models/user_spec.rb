require 'rails_helper'

describe User do
  # shared contexts

  ## email

  shared_context 'it has a valid email' do
    subject { build :user, email: email }
    it { is_expected.to be_valid }
  end

  shared_context 'it has a invalid email' do
    subject { build :user, email: email }
    it { is_expected.not_to be_valid }
  end

  ## password

  shared_context 'it has a valid password' do
    subject do
      build :user, {
        password:              password,
        password_confirmation: password,
      }
    end

    it { is_expected.to be_valid }
  end

  shared_context 'it has a invalid password' do
    subject do
      begin
        confirmation = password_confirmation
      rescue
        confirmation = password
      end

      build :user, {
        password:              password,
        password_confirmation: confirmation,
      }
    end

    it { is_expected.not_to be_valid }
  end

  ## first_name

  shared_context 'it has a valid first name' do
    subject { build :user, first_name: first_name }
    it { is_expected.to be_valid }
  end

  shared_context 'it has a invalid first name' do
    subject { build :user, first_name: first_name }
    it { is_expected.not_to be_valid }
  end

  ## last_name

  shared_context 'it has a valid last name' do
    subject { build :user, last_name: last_name }
    it { is_expected.to be_valid }
  end

  shared_context 'it has a invalid last name' do
    subject { build :user, last_name: last_name }
    it { is_expected.not_to be_valid }
  end

  ## details

  shared_context 'it has valid details' do
    subject { build :user, details: details }
    it { is_expected.to be_valid }
  end

  shared_context 'it has invalid details' do
    subject { build :user, details: details }
    it { is_expected.not_to be_valid }
  end

  # tests

  ## email

  context 'with no email' do
    let(:email) { '' }
    it_behaves_like 'it has a invalid email'
  end

  context 'with an email' do
    let(:email) { 'test@example.com' }
    it_behaves_like 'it has a valid email'
  end

  ## password

  context 'with a valid password' do
    let(:password) { '12345678' }
    it_behaves_like 'it has a valid password'
  end

  context 'with no password' do
    let(:password) { '' }
    it_behaves_like 'it has a invalid password'
  end

  context 'with a password and password_confirmation that do not match' do
    let(:password)              { '12345678' }
    let(:password_confirmation) { '123456789' }
    it_behaves_like 'it has a invalid password'
  end

  context 'with a password less than 8 characters' do
    let(:password) { 'x' * 7 }
    it_behaves_like 'it has a invalid password'
  end

  context 'with a password more than 72 characters' do
    let(:password) { 'x' * 73 }
    it_behaves_like 'it has a invalid password'
  end

  ## first name

  context 'with a first name' do
    let(:first_name) { 'Joanna' }
    it_behaves_like 'it has a valid first name'
  end

  context 'with no first name' do
    let(:first_name) { '' }
    it_behaves_like 'it has a invalid first name'
  end

  ## last name

  context 'with a last name' do
    let(:last_name) { 'Smith' }
    it_behaves_like 'it has a valid last name'
  end

  context 'with no last name' do
    let(:last_name) { '' }
    it_behaves_like 'it has a invalid last name'
  end

  ## details

  context 'with valid details' do
    let(:details) { build :end_user_detail }
    it_behaves_like 'it has valid details'
  end

  context 'with no details' do
    let(:details) { nil }
    it_behaves_like 'it has invalid details'
  end

  context 'with invalid details' do
    let(:details) { build :end_user_detail, zip: '4444' }
    it_behaves_like 'it has invalid details'
  end
end
