# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostComment, 'post_commentモデルに関するテスト', type: :model do
  before do
    end_user = FactoryBot.create(:end_user)
    record = FactoryBot.create(:record, end_user: end_user)
    @comment = FactoryBot.build(:post_comment, end_user_id: end_user.id, record_id: record.id)
  end

  describe 'コメント機能' do
    context 'コメントを保存できる場合' do
      it 'コメント文を入力していれば保存できる' do
        expect(@comment). to be_valid
      end
    end

    context 'コメントを保存できない場合' do
      it 'コメントが空の場合は投稿できない' do
        @comment.comment = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Comment can't be blank", "Comment is too short (minimum is 1 character)"
      end
    end
  end

end