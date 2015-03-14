require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    Rails.application.load_seed
  end
  specify 'sample data loaded' do
    expect(User.count).to be > 0
    expect(Message.count).to be > 0
  end

  describe '::headlines_for' do
    let(:contents) do
      user = User.find_by_name user_name
      Message.headlines_for(user).map(&:content)
    end
    context 'はなこ' do
      let(:user_name) { 'はなこ' }
      it 'returns headlines' do
        expect(contents).to eq %w(何だい、はなこ？ 何のようですか？たかし)
      end
    end
    context 'たかし' do
      let(:user_name) { 'たかし' }
      it 'returns headlines' do
        expect(contents).to eq %w(たかし、来週ひま？ 何のようですか？たかし)
      end
    end
    context 'ひろし' do
      let(:user_name) { 'ひろし' }
      it 'returns headlines' do
        expect(contents).to eq %w(何だい、はなこ？ たかし、来週ひま？)
      end
    end
  end
end
