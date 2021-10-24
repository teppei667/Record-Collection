# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, 'favoriteモデルに関するテスト', type: :model do
  before do
    end_user = FactoryBot.create(:end_user)
    record = FactoryBot.create(:record, end_user: end_user)
    @favorite = FactoryBot.build(:favorite, end_user_id: end_user.id, record_id: record.id)
  end

  describe 'いいね機能' do
    context 'いいねできる場合' do
      it "end_user_idとrecord_idがあれば保存できる" do
        expect(@favorite).to be_valid
      end
    end
  end
end