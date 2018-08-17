class ClubsController < ApplicationController
  before_action :require_login, except: [:index]
  before_action :load_club, only: [:show, :edit, :update]
  before_action :require_ownership, only: [:edit, :update]
  before_action :require_role, only: [:show]

  def index
    @clubs = Club.all
  end

  def show
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(
      name: params[:club][:name],
      description: params[:club][:description],
      user: current_user
    )

    if @club.save
      redirect_to root_path
    else
      flash.now[:alert] = @club.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @club && @club.update(name: params[:club][:name], description: params[:club][:description], user: current_user)
      redirect_to root_path
    else
      flash.now[:alert] = @club.errors.full_messages
      render :edit
    end
  end

  private

  def require_login
    if !current_user
      flash[:alert] = ["You must be logged in to do this."]
      redirect_to new_session_path
    end
  end

  def require_ownership
    if current_user != @club.user
      flash[:alert] = ["You're not the owner of this club, access denied!"]
      redirect_to root_path
    end
  end

  def load_club
    @club = Club.find(params[:id])
  end

  def require_role
    if Club.banned_roles.include?(current_user.role)
      flash[:alert] = ["Only wizards and hobbits may enter!"]
      redirect_to root_path
    end
  end
end
