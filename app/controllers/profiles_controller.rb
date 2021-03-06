class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  # GET request to /user/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  
    # POST request to /user/:user_id/profile
  def create
  
    # Ensure that we have the user who is filling out the form
    @user = User.find( params[:user_id] )
    
    # Create the profile linked to this user
    @profile = @user.build_profile( profile_params )

    # Save profile to the database    
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
    
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    
    @user = User.find( params[:user_id] )
    @profile = @user.profile
    
  end
  
  # PUT to /users/:user_id/profile
  def update

    # Retrieve user & profile from database
    @user = User.find( params[:user_id] )
    @profile = @user.profile
    
    # Mass assign profile attributes and save
    if @profile.update_attributes(profile_params)
      flash[:success] = "User updated!"
      # redirect user to their profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
    
  end


  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :contact_email, :description)
    end
  
    def only_current_user
      @user = User.find( params[:user_id])
      redirect_to(root_url) unless @user == current_user
    end
  
end