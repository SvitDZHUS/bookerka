# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  after do
    logout(user)
  end

  describe 'GET /show' do
    it 'returns http success' do
      get profile_url(user.profile)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_profile_url(user.profile)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:edited_profile) { attributes_for(:profile) }

      it 'updates the requested book' do
        get edit_profile_url(user.profile)
        expect(response).to render_template(:edit)
        patch profile_url(user.profile), params: { profile: edited_profile }
        expect(response).to redirect_to(profile_url(user.profile))
        follow_redirect!
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid parameters' do
      let(:edited_invalid_profile) { attributes_for(:profile, :invalid_profile) }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        get edit_profile_url(user.profile)
        expect(response).to render_template(:edit)
        patch profile_url(user.profile), params: { profile: edited_invalid_profile }
        expect(response).to render_template(:edit)
      end
    end
  end
end
