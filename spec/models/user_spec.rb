require 'rails_helper'

describe User do
  # shared contexts

  shared_context 'it has a bad email' do
    subject { build :user, email: email }
    it { is_expected.not_to be_valid }
  end

  shared_context 'it has a bad password' do
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

  shared_context 'it has a bad first name' do
    subject { build :user, first_name: first_name }
    it { is_expected.not_to be_valid }
  end

  shared_context 'it has a bad last name' do
    subject { build :user, last_name: last_name }
    it { is_expected.not_to be_valid }
  end

  shared_context 'it has bad details' do
    subject { build :user, details: details }
    it { is_expected.not_to be_valid }
  end

  # tests

  context "with no email" do
    let(:email) { '' }
    it_behaves_like 'it has a bad email'
  end

  context "with no password" do
    let(:password) { '' }
    it_behaves_like 'it has a bad password'
  end

  context "with a password and password_confirmation that do not match" do
    let(:password)              { '12345678' }
    let(:password_confirmation) { password + '9' }
    it_behaves_like 'it has a bad password'
  end

  context "with a password less than 8 characters" do
    let(:password) { '1234567' }
    it_behaves_like 'it has a bad password'
  end

  context "with a password more than 72 characters" do
    let(:password) { '1234567890' * 7 + '123' }
    it_behaves_like 'it has a bad password'
  end

  context "with no first name" do
    let(:first_name) { '' }
    it_behaves_like 'it has a bad first name'
  end

  context "with no last name" do
    let(:last_name) { '' }
    it_behaves_like 'it has a bad last name'
  end

  context "with no details" do
    let(:details) { nil }
    it_behaves_like 'it has bad details'
  end

  context "with invalid details" do
    let(:details) { build :end_user_detail, zip: '4444' }
    it_behaves_like 'it has bad details'
  end
end
