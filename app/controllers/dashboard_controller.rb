# frozen_string_literal: true

class DashboardController < ApplicationController
  layout 'application'

  before_action :authenticate_user!

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError do
    redirect_to authenticated_root_path, notice: t('global.access')
  end
end
