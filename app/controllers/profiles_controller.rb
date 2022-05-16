# frozen_string_literal: true

class ProfilesController < DashboardController
  before_action :set_profile, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: t('.controller.update') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = authorize Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthday)
  end
end
