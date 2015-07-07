require 'rails_helper'

describe User do
  subject { create :user }

  it { is_expected.to be_valid }

  context "with no email" do
    subject { create :user, email: '' }
    it { is_expected.not_to be_valid }
  end

  context "with no password" do
    subject { create :user, password: '', password_confirmation: '' }
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
