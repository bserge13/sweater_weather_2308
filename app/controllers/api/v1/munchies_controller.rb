class Api::V1::MunchiesController < ApplicationController 
  def index 
    munchie_search = MunchiesFacade.munchie_search(params[:location], params[:food])
    render json: MunchiesSerializer.new(munchie_search)
  end
end