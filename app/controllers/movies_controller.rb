class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
      @all_ratings= Movie.all_ratings
     @column = params[:sort]
     @column=session[:sort]
    @ratings=params[:ratings]||session[:ratings]||first_timerating
    #@ratings = session [:ratings]
    @movies = Movie.where({rating: @ratings.keys}).order(@column)
    #@movies = Movie.order(params[:sort_by])
    #sorting at database level
    session[:ratings]=@ratings
   session[:sort]=@column
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
    @director=Movie.directors
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

def first_timerating
  hash={}
  @all_ratings.each{|x| hash[x] ='1'}
  hash
end

=begin
 def directors
    @movie = Movie.find(params[:id])
    @movies = @movie.same_directors
    if (@movies-[@movie]).empty?
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to movies_path
    end
 end
=end
  def same_director
    id = params[:id]
    @movie = Movie.find params [:id]
    if (@movie.director.length == 0)
      flash[:notice] = "'#{@movie.title}' has no director info."
      redirect_to movies_path
    end
    @movies = Movie.find_by_director(@movie.director)
  # @movie = Movie.find_by_director(params[:director])
  end


