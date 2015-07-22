require 'rails_helper'

describe ApplicationController do
  # subject

  subject { described_class.new }

  # before

  before :each do
    log_in user
  end

  # tests

  describe '.current_user' do
    subject { super().current_user }

    context 'while logged in' do
      let(:user) { create :user }
      it { is_expected.to be user }
    end

    context 'while not logged in' do
      let(:user) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '.admin_user?' do
    subject { super().admin_user? }

    context 'while logged in as an end user' do
      let(:user) { create :user }
      it { is_expected.to be false }
    end

    context 'while logged in as an admin user' do
      let(:user) { create :user, :administrator }
      it { is_expected.to be true }
    end

    context 'while not logged in' do
      let(:user) { nil }
      it { is_expected.to be false }
    end
  end

  describe '.end_user?' do
    subject { super().end_user? }

    context 'while logged in as an end user' do
      let(:user) { create :user }
      it { is_expected.to be true }
    end

    context 'while logged in as an admin user' do
      let(:user) { create :user, :administrator }
      it { is_expected.to be false }
    end

    context 'while not logged in' do
      let(:user) { nil }
      it { is_expected.to be false }
    end
  end
end
