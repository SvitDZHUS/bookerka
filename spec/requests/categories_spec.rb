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
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /edit' do
    let(:valid_category) { create(:category) }

    it 'render a successful response' do
      get edit_category_url(valid_category)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_category) do
        {
          category_name: Faker::Lorem.characters(number: 10)
        }
      end

      it 'creates a new category' do
        post categories_url, params: { category: valid_category }
        expect(response).to redirect_to categories_url
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include('Category was successfully created')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_category) { build(:category, :invalid_category) }

      it 'does not create a new category' do
        expect(invalid_category).not_to be_valid
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        get new_category_url
        expect(response).to render_template(:new)
        expect(invalid_category).not_to be_valid
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let!(:valid_category) { create(:category, created_by: user) }
      let(:edited_category) do
        {
          title: Faker::Lorem.characters(number: 3),
          content: Faker::Lorem.characters(number: 20)
        }
      end

      it 'updates the requested category' do
        get edit_category_url(valid_category)
        expect(response).to render_template(:edit)
        patch category_url(valid_category), params: { category: edited_category }
        expect(response).to redirect_to(category_url(valid_category))
        follow_redirect!
        expect(response).to render_template(:show)
        expect(response.body).to include('Category was successfully updated')
      end
    end

    context 'with invalid parameters' do
      let!(:valid_category) { create(:category, created_by: user) }
      let(:edited_invalid_category) do
        {
          title: Faker::Lorem.characters(number: 40),
          content: ' '
        }
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        get edit_category_url(valid_category)
        expect(response).to render_template(:edit)
        patch category_url(valid_category), params: { category: edited_invalid_category }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:valid_category) { create(:category, created_by: user) }

    it 'destroys the requested category' do
      expect { delete category_url(valid_category) }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categorys list' do
      delete category_url(valid_category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
