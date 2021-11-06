# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
      it 'トップページにサインインページへのリンクが表示されていてリンクの内容が正しい' do
        expect(page).to have_link "", href: new_end_user_session_path
        sign_in_link = find_all('a')[1].native.inner_text
        expect(page).to have_link sign_in_link, href: new_end_user_session_path
      end
      it 'トップページにサインアップページのリンクが表示されていてリンクの内容が正しい' do
        expect(page).to have_link "", href: new_end_user_registration_path
        sign_up_link = find_all('a')[0].native.inner_text
        expect(page).to have_link sign_up_link, href: new_end_user_registration_path
      end
      it 'トップページにお問い合わせのリンクが表示されていてリンクの内容が正しい' do
        expect(page).to have_link "", href: new_contact_path
        contact_link = find_all('a')[3].native.inner_text
        expect(page).to have_link contact_link, href: new_contact_path
      end
      it 'トップページに利用規約のリンクが表示されていてリンクの内容が正しい' do
        expect(page).to have_link "", href: terms_of_use_path
        terms_of_use_link = find_all('a')[2].native.inner_text
        expect(page).to have_link terms_of_use_link, href: terms_of_use_path
      end
    end
  end

  describe '利用規約画面のテスト' do
    before do
      visit terms_of_use_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/terms_of_use'
      end
    end
  end

  describe 'お問い合わせ画面のテスト' do
    before do
      visit new_contact_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contacts/new'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_end_user_registration_path
    end

    context '表示内容に確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/end_users/sign_up'
      end
      it 'Sign upと表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'end_user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'end_user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'end_user[password]'
      end
      it 'password confirmationフォームが表示される' do
        expect(page).to have_field 'end_user[password_confirmation]'
      end
      it 'sign_upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'end_user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'end_user[email]', with: Faker::Internet.email
        fill_in 'end_user[password]', with: 'password'
        fill_in 'end_user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(EndUser.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先がmypageになっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/end_users/' + EndUser.last.id.to_s + '/mypage/' + EndUser.last.id.to_s
      end
    end
  end
  
  describe 'ユーザログインテスト' do
    let(:end_user) { create(:end_user) }

    before do
      visit new_end_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/end_users/sign_in'
      end
      it '「login」と表示される' do
        expect(page).to have_content 'login'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'end_user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'end_user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功テスト' do
      before do
        fill_in 'end_user[email]', with: end_user.email
        fill_in 'end_user[password]', with: end_user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が、mypageになっている' do
        expect(current_path).to eq '/end_users/' + end_user.id.to_s + '/mypage/' + end_user.id.to_s
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'end_user[email]', with: ''
        fill_in 'end_user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗したらログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/end_users/sign_in'
      end
    end
  end

  # ログアウトテストの実装
  describe 'ユーザログアウトのテスト' do
    let(:end_user) { create(:end_user) }

    before do
      visit new_end_user_session_path
      fill_in 'end_user[email]', with: end_user.email
      fill_in 'end_user[password]', with: end_user.password
      click_button 'Log in'
      logout_link = find('#test').native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてサインインへのリンクが存在する' do
        expect(page).to have_link '', href: '/end_users/sign_in'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
