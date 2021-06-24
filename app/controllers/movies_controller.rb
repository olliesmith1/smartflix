class MoviesController < ApplicationController
  def show
    render json: Apis::Omdb::Movie.new(params[:title]).call
  end
end
