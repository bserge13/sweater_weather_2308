class Api::V1::MunchiesController < ApplicationController 
  def index 
    munchie_search = MunchieFacade.munchie_search(params[:destination], params[:food])
    render json: MunchieSerializer.new(munchie_search)
  end
end