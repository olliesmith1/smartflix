# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by(title: params[:title].titleize)

    if @movie
      render "show", status: :ok
    else
      render json: {
        error: "Movie with title #{params[:title]} not found. We have requested this to be added to our library."
      }, status: :not_found
      CreateMovieWorker.perform_async(params[:title])
    end
  end

  def index
    @movies = Kaminari.paginate_array(Movie.all).page(params[:page]).per(5)
    render "index"
  end
end
