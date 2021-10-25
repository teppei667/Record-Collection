# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:end_user) { create(:end_user) }
  let!(:other_end_user) { create(:end_user) }
  let!(:record) { create(:record, end_user: end_user) }
  let!(:other_record) { create(:record, end_user: other_end_user) }
  let!(:favorite) { create(:favorite, end_user: end_user, record: record) }

  before do
    visit new_end_user_session_path
    fill_in 'end_user[email]', with: end_user.email
    fill_in 'end_user[password]', with: end_user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト:　ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'My Recordsを押すと、mypageに遷移する' do
        mypage_link = find_all('a')[1].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/mypage/' + end_user.id.to_s
      end
      it 'Searchを押すと、レコード一覧画面に遷移する' do
        end_users_link = find_all('a')[2].native.inner_text
        end_users_link = end_users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link end_users_link
        is_expected.to eq '/records'
      end
      it 'DMを押すと、投稿一覧画面に遷移する' do
        dm_link = find_all('a')[3].native.inner_text
        dm_link = dm_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link dm_link
        is_expected.to eq '/rooms'
      end
    end
  end

  describe 'mypageのテスト' do
    before do
      visit mypage_path(end_user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/mypage/' + end_user.id.to_s
      end
      it 'レコードの画像のリンク先が正しい' do
        expect(page).to have_link '', href: record_path(record)
      end
      it 'レコード投稿画面へのリンク先が正しい' do
        expect(page).to have_link '', href: new_record_path
      end
    end
  end

  describe 'レコード投稿画面のテスト' do
    before do
      visit new_record_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/records/new'
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'record[title]'
      end
      it 'artist_nameフォームが表示される' do
        expect(page).to have_field 'record[artist_name]'
      end
      it 'introductionフォームが表示される' do
        expect(page).to have_field 'record[introduction]'
      end
      it 'release_dateフォームが表示される' do
        expect(page).to have_field 'record[release_date(1i)]'
      end
      it 'genreフォームが表示される' do
        expect(page).to have_field 'record[genre]'
      end
      it 'COLLECTEDボタンが表示される' do
        expect(page).to have_button ''
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'record[title]', with: record.title
        fill_in 'record[artist_name]', with: record.artist_name
        fill_in 'record[introduction]', with: record.introduction
        select record.release_date.year, from: 'record[release_date(1i)]'
        select record.genre, from: 'record[genre]'
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button 'new_record_button' }.to change(end_user.records, :count).by(1)
      end
      it 'リダイレクト先が、mypageになっている' do
        click_button 'new_record_button'
        expect(current_path).to eq '/mypage/' + end_user.id.to_s
      end
    end
  end

  describe 'レコードの詳細画面のテスト' do
    before do
      visit record_path(record)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/records/' + record.id.to_s
      end
      it '各投稿ユーザのmypageへのリンクが表示されている' do
        expect(page).to have_link record.end_user.name, href: end_user_path(record.end_user)
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content record.title
      end
      it '投稿のartist_nameが表示される' do
        expect(page).to have_content record.artist_name
      end
      it '投稿のintroductionが表示される' do
        expect(page).to have_content record.introduction
      end
      it '投稿のrelease_dateが表示される' do
        expect(page).to have_content record.release_date.year
      end
      it '投稿のgenreが表示される' do
        expect(page).to have_content record.genre
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_record_path(record)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: record_path(record)
      end
      it 'コメント投稿フォームが表示される' do
        expect(page).to have_field 'post_comment[comment]'
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/records/' + record.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end

      it '正しく削除される' do
        expect(Record.where(id: record.id).count).to eq 0
      end

      it 'リダイレクト先がmypageに設定されている' do
        expect(current_path).to eq '/mypage/' + end_user.id.to_s
      end
    end
  end

  describe 'レコード編集画面のテスト' do
    before do
      visit edit_record_path(record)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/records/' + record.id.to_s + '/edit'
      end
      it 'image編集フォームが表示される' do
        expect(page).to have_field 'record[image]'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'record[title]', with: record.title
      end
      it 'artist_name編集フォームが表示される' do
        expect(page).to have_field 'record[artist_name]', with: record.artist_name
      end
      it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'record[introduction]', with: record.introduction
      end
      it 'release_date編集フォームが表示される' do
        expect(page).to have_field 'record[release_date(1i)]', with: record.release_date.year
      end
      it 'genre編集フォームが表示される' do
        expect(page).to have_field 'record[genre]', with: record.genre
      end
    end

    context '編集成功テスト' do
      before do
        @record_old_title = record.title
        @record_old_artist_name = record.artist_name
        @record_old_introduction = record.introduction
        @record_old_release_date = record.release_date.year
        @record_old_genre = record.genre
        fill_in 'record[title]', with: Faker::Lorem.characters(number: 20)
        fill_in 'record[artist_name]', with: Faker::Lorem.characters(number: 15)
        fill_in 'record[introduction]', with: Faker::Lorem.characters(number: 100)
        select record.release_date.year, from: 'record[release_date(1i)]'
        select 'pops', from: 'record[genre]'
        click_button 'edit_record_button'
      end

      it 'titleが正しく更新される' do
        expect(record.reload.title).not_to eq @record_old_title
      end
      it 'artist_nameが正しく更新される' do
        expect(record.reload.artist_name).not_to eq @record_old_artist_name
      end
      it 'introductionが正しく更新される' do
        expect(record.reload.introduction).not_to eq @record_old_introduction
      end
      it 'release_dataが正しく更新される' do
        expect(record.reload.release_date).not_to eq @record_old_release_date
      end
      it 'genreが正しく更新される' do
        expect(record.reload.genre).not_to eq @record_old_genre
      end
    end
  end

  describe 'レコード一覧画面のテスト' do
    before do
      visit records_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/records'
      end
      it '検索フォームが表示されている' do
        expect(page).to have_field 'keyword'
      end
      it 'ユーザー一覧へのリンクが表示されている' do
        expect(page).to have_link 'ユーザ一覧へ', href: end_users_path
      end
      it '投稿されている全てのレコードの画像が表示される' do
        expect(page).to have_link record.image, href: record_path(record)
        expect(page).to have_link other_record.image, href: record_path(other_record)
      end
    end
  end

  describe 'ユーザ一覧画面のテスト' do
    before do
      visit end_users_path
    end

    context '表示内容が正しい' do
      it 'URLが正しい' do
        expect(current_path).to eq '/end_users'
      end
      it '検索フォームが表示されている' do
        expect(page).to have_field 'keyword'
      end
      it 'レコード一覧画面へのリンクが表示されている' do
        expect(page).to have_link 'レコード一覧へ', href: records_path
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: end_user_path(record.end_user)
        expect(page).to have_link '', href: end_user_path(other_record.end_user)
      end
      it '自分と他人の名前のリンクが正しい' do
        expect(page).to have_link end_user.name, href: end_user_path(record.end_user)
        expect(page).to have_link other_end_user.name, href: end_user_path(other_record.end_user)
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit end_user_path(end_user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/end_users/' + end_user.id.to_s
      end
      it '編集画面へのリンクの表示が正しい' do
        expect(page).to have_link '編集', href: edit_end_user_path(end_user)
      end
      it 'フォロー一覧画面へのリンクが表示されている' do
        expect(page).to have_link 'フォロー', href: end_user_followings_path(end_user)
      end
      it 'フォロワー一覧画面へのリンクが表示されている' do
        expect(page).to have_link 'フォロワー', href: end_user_followers_path(end_user)
      end
      it '自分がお気に入りしたレコードの詳細画面へのリンクが表示されている' do
        expect(page).to have_link '', href: record_path(favorite.record)
      end
      it '自分のお気に入りしたレコード一覧へのリンクが表示されている' do
        expect(page).to have_link 'お気に入り一覧へ', href: my_favorite_path(end_user)
      end
    end
  end

  describe '自分のユーザ編集画面のテスト' do
    before do
      visit edit_end_user_path(end_user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/end_users/' + end_user.id.to_s + '/edit'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'end_user[name]', with: end_user.name
      end
      it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'end_user[introduction]', with: end_user.introduction
      end
      it 'email編集フォームが表示される' do
        expect(page).to have_field 'end_user[email]', with: end_user.email
      end
    end

    context '更新成功のテスト' do
      before do
        @end_user_old_name = end_user.name
        @end_user_old_introduction = end_user.introduction
        @end_user_old_email = end_user.email
        fill_in 'end_user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'end_user[introduction]', with: Faker::Lorem.characters(number: 100)
        fill_in 'end_user[email]', with: Faker::Internet.email
        click_button 'edit_end_user_button'
      end

      it 'nameが正しく更新される' do
        expect(end_user.reload.name).not_to eq @end_user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(end_user.reload.introduction).not_to eq @end_user_old_introduction
      end
      it 'emailが正しく更新される' do
        expect(end_user.reload.email).not_to eq @end_user_old_email
      end
      it 'リダイレクト先が、自分のユーザー詳細画面になっている' do
        expect(current_path).to eq '/end_users/' + end_user.id.to_s
      end
    end
  end

  describe '自分のお気に入り一覧画面のテスト' do
    before do
      visit my_favorite_path(end_user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/my_favorite/' + end_user.id.to_s
      end
      it '自分がお気に入り登録したレコードの詳細画面へのリンクが表示されている' do
        expect(page).to have_link '', href: record_path(favorite.record)
      end
    end
  end
end
