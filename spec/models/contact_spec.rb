# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '実際に保存してみる' do
    it '全て入力していれば保存できる' do
      expect(FactoryBot.build(:contact)).to be_valid
    end
  end

  describe "バリデーションのチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      contact = Contact.new(name: '', email: 'hogemail.com', message: 'hogehoge')
      expect(contact).to be_invalid
      expect(contact.errors[:name]).to include("can't be blank")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      contact = Contact.new(name: 'hoge', email: '', message: 'hogehoge')
      expect(contact).to be_invalid
      expect(contact.errors[:email]).to include("can't be blank")
    end

    it "messageが空白の場合にバリデーションチェックされ空白のエラーメッセージ返ってきているか" do
      contact = Contact.new(name: 'hoge', email: 'hogemail.com', message: '')
      expect(contact).to be_invalid
      expect(contact.errors[:message]).to include("can't be blank")
    end
  end
end
