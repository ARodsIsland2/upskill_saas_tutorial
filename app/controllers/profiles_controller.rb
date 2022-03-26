class ProfilesController < ApplicationController
  
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
      redirect_to root_path
    else
      render action: :new
    end
    
  end


  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :contact_email, :description)
    end
  
end