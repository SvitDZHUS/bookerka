# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  after do
    logout(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get books_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:valid_book) { create(:book) }

    it 'renders a successful response' do
      get book_url(valid_book)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_book_url
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /edit' do
    let(:valid_book) { create(:book) }

    it 'render a successful response' do
      get edit_book_url(valid_book)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with invalid parameters' do
      let(:invalid_book) { attributes_for(:book, :invalid_book) }

      it "renders a successful response (i.e. to display the 'new' template)" do
        get new_book_url
        expect(response).to render_template(:new)
        post books_url, params: { book: invalid_book }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let!(:valid_book) { create(:book) }
      let(:edited_book) { attributes_for(:book) }

      it 'updates the requested book' do
        get edit_book_url(valid_book)
        expect(response).to render_template(:edit)
        patch book_url(valid_book), params: { book: edited_book }
        expect(response).to redirect_to(book_url(valid_book))
        follow_redirect!
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid parameters' do
      let!(:valid_book) { create(:book) }
      let(:edited_invalid_book) { attributes_for(:book, :invalid_book) }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        get edit_book_url(valid_book)
        expect(response).to render_template(:edit)
        patch book_url(valid_book), params: { book: edited_invalid_book }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:valid_book) { create(:book) }

    it 'destroys the requested book' do
      expect { delete book_url(valid_book) }.to change(Book, :count).by(-1)
    end

    it 'redirects to the books list' do
      delete book_url(valid_book)
      expect(response).to redirect_to(books_url)
    end
  end
end
