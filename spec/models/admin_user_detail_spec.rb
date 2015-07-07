require 'rails_helper'

describe AdminUserDetail do
  subject { create :admin_user_detail }

  it { is_expected.to be_valid }
end
