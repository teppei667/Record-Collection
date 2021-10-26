# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EndUser, 'EndUserモデルに関するテスト', type: :model do
  describe '実際に保存してみる' do
    it "有効な保存内容の場合は保存されるか" do
      expect(FactoryBot.build(:end_user)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      end_user = EndUser.new(name: '', email: 'hogemial.com', password: '123456')
      expect(end_user).to be_invalid
      expect(end_user.errors[:name]).to include("can't be blank")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      end_user = EndUser.new(name: 'hoge', email: '', password: '123456')
      expect(end_user).to be_invalid
      expect(end_user.errors[:email]).to include("can't be blank")
    end
    it "passwordが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      end_user = EndUser.new(name: 'hoge', email: 'hogemial.com', password: '')
      expect(end_user).to be_invalid
      expect(end_user.errors[:password]).to include("can't be blank")
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Recordモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:records).macro).to eq :has_many
      end
    end

    context 'post_commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'entriesモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'direct_messagesモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:direct_messages).macro).to eq :has_many
      end
    end

    context 'roomモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end
  end
end
