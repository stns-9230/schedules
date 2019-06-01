class SchedulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def show
    @schedule = Schedule.find(params[:id])
  end
  
  def new
    @schedule = current_user.schedules.build
  end
  
  def create
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = '予定を投稿しました。'
      redirect_to schedule_url(id: @schedule.id)
    else
      flash.now[:danger] = '予定の投稿に失敗しました。'
      render 'new'
    end
  end  

  def edit
    @schedule = Schedule.find(params[:id])
  end
  
  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = '予定は正常に更新されました。'
      redirect_to @schedule
    else
      flash.now[:danger] = '予定は更新されませんでした。'
      render :edit
    end
  end
  
  def destroy
    @schedule.destroy
    flash[:success] = '予定を削除しました。'
    redirect_to  user_url(id: current_user.id)
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:title, :start, :end, :content)
  end
  
  def correct_user
    @schedule = current_user.schedules.find_by(id: params[:id])
    unless @schedule
    redirect_to root_url
    end
  end
end
