class SponsorsController < ApplicationController
  respond_to :json

  def show
    @sponsors = params[:id].blank? ? Sponsor.all : [Sponsor.find(params[:id])]
    if @sponsors.blank?
      render(json: {errors: {address: [t('errors.not_found', sponsor: t('defaults.sponsor'))]}}, status: 404)
    else
      render json: @sponsors
    end
  end
end
