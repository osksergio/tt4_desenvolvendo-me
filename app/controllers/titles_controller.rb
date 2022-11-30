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
    file_param = params['csv']
    file = File.open(file_param)
    CSV.foreach(file, { headers: true, header_converters: :symbol, col_sep: ',', }) do |row|
      #file.each do |row|
      begin
        #row = row.split(',')
        #next if row[0] == 'show_id'
        #show_id = row[0].strip rescue row[0]
        #type_title = row[1].strip rescue row[1]
        #title = row[2].strip rescue row[2]
        #director = row[3].strip rescue row[3]
        #cast = row[4].strip rescue row[4]
        #country = row[5].strip rescue row[5]
        #date_added = row[6].strip rescue row[6]
        #release_year = row[7].strip rescue row[7]
        #rating = row[8].strip rescue row[8]
        #duration = row[9].strip rescue row[9]
        #listed_in = row[10].strip rescue row[10]
        #description = row[11].strip rescue row[11]

        #Title.create( show_id: show_id, type_title: type_title, title: title, director: director, cast: cast,
        #  country: country, date_added: date_added, release_year: release_year, rating: rating,
        #  duration: duration, listed_in: listed_in, description: description )

        Title.create( show_id: row[:show_id], type_title: row[:type], title: row[:title],
                      director: row[:director], cast: row[:cast], country: row[:country],
                      date_added: row[:date_added], release_year: row[:release_year],
                      rating: row[:rating], duration: row[:duration], listed_in: row[:listed_in],
                      description: row[:description] )
      rescue Exception => err
        errors << err.message
      end
    end

    if errors.blank?
      format.json { render json: { first_message: "Arquivo CSV importado com sucesso!" }, status: :ok }
    else
      render json: { first_message: errors.join(', ') }, status: :unprocessable_entity
    end

    #redirect_to '/titles'
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
