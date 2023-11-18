class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[show edit update alarm set_alarm]

  def show
    @bookmark_lessons = current_user.bookmark_lessons
  end

  def edit ;end

  def alarm ;end

  def set_alarm
    time_params = alarm_time_params
    time_params["alarm_time(5i)"] = "00"

    if @user.update(time_params)
      redirect_to profile_path, notice: 'アラームを設定しました'
    else
      flash.now[:danger] = t('defaults.message.alarm_not_registed')
      redirect_to profile_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'alarmしました'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, alarms_attributes: [:id, :alarm_time, :lesson_id, :_destroy])
  end

  def alarm_time_params
    params.require(:user).permit(:alarm_time)
  end
end
