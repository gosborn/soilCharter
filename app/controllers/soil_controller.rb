class SoilController < ApplicationController

  def data
    render json: SoilDataFetcher.new.data
  end
end
