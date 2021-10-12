require 'rails_helper'

RSpec.describe Friend, type: :model do
  describeq 'relationships' do
    it { should belong_to(:user).with_foreign_key(:user_id) }
  end
end
