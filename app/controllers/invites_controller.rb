class InvitesController < ApplicationController
  def create
  	current_user.invites.create(event_id: params[:invite][:event_id])
		redirect_back(fallback_location: root_url)
  end

  def destroy
  	current_user.invites.destroy(params[:id])
  	redirect_back(fallback_location: root_url)
  end
end
