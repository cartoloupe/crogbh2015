require 'rails_helper'

describe UserTypeExcluding do
  # lets

  let(:the_class)        { described_class } # workaround for context issues
  let(:the_current_user) { user_with_type user_type }

  # subject

  subject { the_class.new *exclude_types }

  # before

  before do
    log_in_as the_current_user
  end

  # tests

  describe '#matches?' do
    subject { super().matches? nil }

    UserTypes.each do |type, _|
      context "excluding type #{type.inspect}" do
        let(:exclude_types) { [type] }

        context "logged in as type #{type.inspect}" do
          let(:user_type) { type }
          it { is_expected.to be false }
        end

        UserTypes.each_except(type) do |other_type, _|
          context "logged in as type #{other_type.inspect}" do
            let(:user_type) { other_type }
            it { is_expected.to be true }
          end
        end
      end
    end

    context "with multiple types" do
      types = UserTypes.types[0..1]
      let(:exclude_types) { types }

      types.each do |type|
        context "for matching type #{type.inspect}" do
          let(:user_type) { type }
          it { is_expected.to be false }
        end
      end

      UserTypes.each_except(*types) do |type, _|
        context "for non-matching type #{type.inspect}" do
          let(:user_type) { type }
          it { is_expected.to be true }
        end
      end
    end
  end
end
