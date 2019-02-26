class ProtGenresController < ApplicationController
  def destroy
    @prot_genres = ProtGenre.find_by(genre_id: params[:genre_id], prot_id: params[:id])
    @prot_genres.destroy if @prot_genres.prot.user == current_user
    redirect_to edit_prot_path(params[:id])
  end
end
