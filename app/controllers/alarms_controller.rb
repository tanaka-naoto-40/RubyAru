class AlarmsController < ApplicationController
  before_action :require_login
  before_action :set_user

  def set_alarm
    time_params = alarm_time_params
    time_params["alarm_time(5i)"] = "00"

    if @user.update(time_params)
      redirect_to profile_path, notice: '通知を設定しました'
    else
      flash.now[:danger] = t('defaults.message.alarm_not_registed')
      redirect_to profile_path
    end
  end

  def remove_alarm
    @user.update(alarm_time: nil)
    redirect_to profile_path, notice: '通知を解除しました'
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def alarm_time_params
    params.require(:user).permit(:alarm_time)
  end
end
