require 'csv'

class TitlesController < ApplicationController
  before_action :set_title, only: [:show, :update, :destroy]
  #skip_before_action :verify_authenticity_token

  # GET /titles
  def index
    @titles = Title.all

    render json: @titles
  end

  # GET /titles/1
  def show
    render json: @title
  end

  # POST /titles
  def create
    @title = Title.new(title_params)

    if @title.save
      render json: @title, status: :created, location: @title
    else
      render json: @title.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /titles/1
  def update
    if @title.update(title_params)
      render json: @title
    else
      render json: @title.errors, status: :unprocessable_entity
    end
  end

  # DELETE /titles/1
  def destroy
    @title.destroy
  end

  def method_test
    render json: { message: 'Deu certo!'}
  end

  def import_csv
    errors = []
    CSV.foreach(params[:csv].path, headers: true) do |row|
      begin
        Title.create( show_id: row[0], type_title: row[1], title: row[2], director: row[3], cast: row[4],
                      country: row[5], date_added: row[6], release_year: row[7], rating: row[8], duration: row[9],
                      listed_in: row[10], description: row[11] )
      rescue Exception => err
        errors << err.message
      end
    end

    if errors.blank?
      render json: { first_message: "Arquivo CSV importado com sucesso!" }, status: :ok
    else
      render json: { first_message: errors.join(', ') }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_title
      @title = Title.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def title_params
      params.require(:title).permit(:show_id, :type_title, :title, :director, :cast, :country, :date_added, :release_year, :rating, :duration, :listed_in, :description)
    end
end
