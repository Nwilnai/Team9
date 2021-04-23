class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
    @game = Game.find(params[:id])
    @user = current_user
    @user_bet = @user.bet_amount
  end

  # GET /games/new
  def new
    @game = Game.new
    GameSession.create(user_id: current_user.id, game_id: @game.id ) 
    @game.add_user(current_user)
    @game.init_game
    @user_bet = params[:q]
    current_user.update_attribute(:bet_amount, @user_bet)
    redirect_to @game
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #gives the user a card and has dealer act as any dealer would, 
  #as per rules of blackjack
  def hit
    @user = current_user
    @game = Game.find(params[:id])
    @user.hit_me(@game)
    redirect_to @game
  end
  
  #User stands, dealer acts according to rules for dealer
  def stand
    @user = current_user
    @user.update_attribute(:has_stood, true)
    @game = Game.find(params[:id])
    redirect_to @game
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.fetch(:game, {})
    end
end
