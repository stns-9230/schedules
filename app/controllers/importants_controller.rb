class ImportantsController < ApplicationController
  before_action :require_user_logged_in
  
  
  def create
    schedule = Schedule.find(params[:schedule_id])
    current_user.important(schedule)
    flash[:success] = "重要な予定に設定しました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    schedule = Schedule.find(params[:schedule_id])
    current_user.unimportant(schedule)
    flash[:success] = "重要な予定を解除しました。"
    redirect_back(fallback_location: root_path)
  end
end
