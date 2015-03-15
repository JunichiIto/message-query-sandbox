require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    Rails.application.load_seed
  end
  specify 'sample data loaded' do
    expect(User.count).to be > 0
    expect(Message.count).to be > 0
  end

  shared_examples 'headlines' do
    let(:user) { User.find_by_name user_name }
    context 'はなこ' do
      let(:user_name) { 'はなこ' }
      it { is_expected.to eq %w(何だい、はなこ？ 何のようですか？たかし) }
    end
    context 'たかし' do
      let(:user_name) { 'たかし' }
      it { is_expected.to eq %w(たかし、来週ひま？ 何のようですか？たかし) }
    end
    context 'ひろし' do
      let(:user_name) { 'ひろし' }
      it { is_expected.to eq %w(何だい、はなこ？ たかし、来週ひま？) }
    end
  end

  describe '::headlines_for' do
    subject do
      Message.headlines_for(user).map(&:content)
    end
    it_behaves_like 'headlines'
  end

  describe 'use HeadlinesFinder' do
    subject do
      Messages::HeadlinesFinder.new(user).call.map(&:content)
    end
    it_behaves_like 'headlines'
  end
end