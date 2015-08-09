class ThingsController < ApplicationController
  respond_to :json

  def show
    @things = Thing.find_closest(params[:lat], params[:lng], params[:limit] || 10)
    if @things.blank?
      render(json: {errors: {address: [t('errors.not_found', thing: t('defaults.thing'))]}}, status: 404)
    else
      respond_with @things
    end
  end

  def update
    @thing = Thing.find(params[:id])
    old_thing_user_id = @thing.user_id
    if @thing.update_attributes(thing_params)
      mail_handler old_thing_user_id
      respond_with @thing
    else
      render(json: {errors: @thing.errors}, status: 500)
    end
  end

  private

  ## 
  # Determines if state change happened that requires email
  # and sends the email
  def mail_handler(old_thing_user_id)
    ThingMailer.abandon(@thing, User.find_by_id(old_thing_user_id).email).deliver if is_abandon?(old_thing_user_id)
    ThingMailer.adopt(@thing).deliver if is_adopt?(old_thing_user_id)
  end

  ##
  # A tree is only abandoned if it used to have a user and no longer does
  def is_abandon?(old_thing_user_id)
    !old_thing_user_id.nil? && @thing.user_id.nil?
  end

  ##
  # A tree is only adopted if it used to have no user and now it does
  def is_adopt?(old_thing_user_id)
    old_thing_user_id.nil? && !@thing.user_id.nil?
  end

  def thing_params
    params.require(:thing).permit(:name, :user_id)
  end
end
