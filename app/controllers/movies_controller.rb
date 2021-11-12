# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    title = params[:title].titleize
    @movie = Movie.find_by(title: title)

    if @movie
      render json: @movie, status: :ok
    else
      render json: {
        error: "Movie with title #{title} not found. We have requested this to be added to our library."
      }, status: :not_found
      CreateMovieWorker.perform_async(title)
    end
  end

  def index
    @movies = Kaminari.paginate_array(Movie.all).page(params[:page]).per(3)
    render "index"
  end
end
