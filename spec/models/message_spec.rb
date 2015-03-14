require 'rails_helper'

RSpec.describe Message, type: :model do
  specify 'sample data loaded' do
    expect(User.count).to be > 0
    expect(Message.count).to be > 0
  end
end
