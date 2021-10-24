# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, 'recordモデルに関するテスト', type: :model do
  describe '実際に保存してみる' do
    it "有効な保存内容の場合は保存されるか" do
      expect(FactoryBot.build(:record)).to be_valid
    end
  end
  context "バリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      record = Record.new(title: '', artist_name: 'hoge', introduction: 'hogehoge')
      expect(record).to be_invalid
      expect(record.errors[:title]).to include("can't be blank")
    end
    it "artist_nameがが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      record = Record.new(title: 'hoge', artist_name: '', introduction: 'hogehoge')
      expect(record).to be_invalid
      expect(record.errors[:artist_name]).to include("can't be blank")
    end
    it "introductionがが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      record = Record.new(title: 'hoge', artist_name: 'hoge', introduction: '')
      expect(record).to be_invalid
      expect(record.errors[:introduction]).to include("can't be blank")
    end
    it "genreがが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      record = Record.new(title: 'hoge', artist_name: 'hoge', introduction: 'hoge', genre: '')
      expect(record).to be_invalid
      expect(record.errors[:genre]).to include("can't be blank")
    end
    it "release_dateがが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      record = Record.new(title: 'hoge', artist_name: 'hoge', introduction: 'hoge', release_date: '')
      expect(record).to be_invalid
      expect(record.errors[:release_date]).to include("can't be blank")
    end
  end

  describe 'アソシエーションのテスト' do
    context 'EndUserモデルとの関係'do
      it 'N:1となっている' do
        expect(Record.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end
    context 'post_commentモデルとの関係'do
      it '1:Nとなっている' do
        expect(Record.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'favoriteモデルとの関係'do
      it '1:Nとなっている' do
        expect(Record.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end