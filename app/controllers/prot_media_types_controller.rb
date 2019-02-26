class ProtMediaTypesController < ApplicationController

  def destroy
    @prot_media_types = ProtMediaType.find_by(media_type_id: params[:media_type_id], prot_id: params[:id])
    @prot_media_types.destroy if @prot_media_types.prot.user == current_user
    redirect_to edit_prot_path(params[:id])
  end
end
