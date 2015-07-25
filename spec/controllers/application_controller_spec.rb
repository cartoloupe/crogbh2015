require 'rails_helper'

describe ApplicationController do
  # lets

  let(:an_end_user)      { create :user }
  let(:an_admin_user)    { create :user, :administrator }
  let(:the_current_user) { }

  # subject

  subject { controller }

  # before

  before :each do
    unless the_current_user.nil?
      log_in_as the_current_user
    else
      log_out
    end
  end

  # tests

  describe '.current_user' do
    subject { super().current_user }

    context 'while logged in' do
      let(:the_current_user) { an_end_user}
      it { is_expected.to be the_current_user }
    end

    context 'while not logged in' do
      it { is_expected.to be_nil }
    end
  end

  describe '.admin_user?' do
    subject { super().admin_user? }

    context 'while logged in as an end user' do
      let(:the_current_user) { an_end_user }
      it { is_expected.to be false }
    end

    context 'while logged in as an admin user' do
      let(:the_current_user) { an_admin_user }
      it { is_expected.to be true }
    end

    context 'while not logged in' do
      it { is_expected.to be false }
    end
  end

  describe '.end_user?' do
    subject { super().end_user? }

    context 'while logged in as an end user' do
      let(:the_current_user) { an_end_user }
      it { is_expected.to be true }
    end

    context 'while logged in as an admin user' do
      let(:the_current_user) { an_admin_user }
      it { is_expected.to be false }
    end

    context 'while not logged in' do
      it { is_expected.to be false }
    end
  end
end
