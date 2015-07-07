require 'rails_helper'

describe User do
  subject { create :user }

  it { is_expected.to be_valid }

  context "with no email" do
    subject { create :user, email: '' }
    it { is_expected.not_to be_valid }
  end

  context "with no password" do
    let(:password) { '' }

    subject do
      create :user,
        password:              password,
        password_confirmation: password
    end

    it { is_expected.not_to be_valid }
  end

  context "with a password and password_confirmation that do not match" do
    let(:password) { '' }

    subject do
      create :user,
        password:              password,
        password_confirmation: password + 'x'
    end

    it { is_expected.not_to be_valid }
  end

  context "with a password less than 8 characters" do
    let(:password) { '1234567' }

    subject do
      create :user,
        password:              password,
        password_confirmation: password
    end

    it { is_expected.not_to be_valid }
  end

  context "with a password more than 72 characters" do
    let(:password) { '12345678' * 9 + '1' }

    subject do
      create :user,
        password:              password,
        password_confirmation: password
    end

    it { is_expected.not_to be_valid }
  end

  context "with no first name" do
    subject { create :user, first_name: '' }
    it { is_expected.not_to be_valid }
  end

  context "with no last name" do
    subject { create :user, last_name: '' }
    it { is_expected.not_to be_valid }
  end

  context "with no details" do
    subject { create :user, details: nil }
    it { is_expected.not_to be_valid }
  end
end
