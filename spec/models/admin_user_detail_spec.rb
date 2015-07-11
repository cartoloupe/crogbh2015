require 'rails_helper'

describe AdminUserDetail do
  # subject

  subject { create :admin_user_detail }

  # behaviors

  it_behaves_like 'a user detail model'

  # tests

  it { is_expected.to be_valid }
end
