require 'rails_helper'

describe CurrentUser do
  # lets

  let(:an_end_user)      { create :user }
  let(:an_admin_user)    { create :user, :administrator }
  let(:the_current_user) { }

  # subject

  subject { described_class }

  # before

  before :each do
    log_in_as the_current_user
  end

  # tests

  describe '.record' do
    subject { super().record }

    context 'while logged in' do
      let(:the_current_user) { an_end_user }
      it { is_expected.to be the_current_user }
    end

    context 'while not logged in' do
      it { is_expected.to be_nil }
    end
  end

  describe '.type' do
    subject { super().type }

    before :each do
      log_in_as user_with_type user_type
    end

    UserTypes.each do |type, _|
      context "while logged in as user type #{type.inspect}" do
        let(:user_type) { type }
        it { is_expected.to be type }
      end
    end
  end

  # type check methods per user type
  UserTypes.types.each do |user_type|
    describe ".#{user_type}?" do
      subject { super().send("#{user_type}?") }

      context "logged in as type #{user_type.inspect}" do
        let(:the_current_user) { user_with_type user_type }
        it { is_expected.to be true }
      end

      UserTypes.each_except(user_type) do |other_type, _|
        context "logged in as type #{other_type.inspect}" do
          let(:the_current_user) { user_with_type other_type }
          it { is_expected.to be false }
        end
      end
    end
  end

  describe '.log_in' do
    subject { super().log_in an_end_user }

    it 'logs in that user' do
      expect(CurrentUser.record).to eq an_end_user
    end
  end

  describe '.log_out' do
    subject { super().log_out }

    it 'logs out the current user' do
      CurrentUser.log_in an_end_user
      subject
      expect(CurrentUser.none?).to be true
    end
  end
end
