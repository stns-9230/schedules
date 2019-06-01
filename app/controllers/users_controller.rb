class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
    @schedule = current_user.schedules.build
    schedules = @user.schedules
    @next = schedules.where('start >= ?', Time.zone.now).order(start: :asc).first
    @day1 = schedules.where(start: Time.zone.today.beginning_of_day...Time.zone.today.end_of_day)
    @day2 = schedules.where(start: Time.zone.today.since(1.days).beginning_of_day...Time.zone.today.since(1.days).end_of_day)
    @day3 = schedules.where(start: Time.zone.today.since(2.days).beginning_of_day...Time.zone.today.since(2.days).end_of_day)
    @day4 = schedules.where(start: Time.zone.today.since(3.days).beginning_of_day...Time.zone.today.since(3.days).end_of_day)
    @day5 = schedules.where(start: Time.zone.today.since(4.days).beginning_of_day...Time.zone.today.since(4.days).end_of_day)
    @day6 = schedules.where(start: Time.zone.today.since(5.days).beginning_of_day...Time.zone.today.since(5.days).end_of_day)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
