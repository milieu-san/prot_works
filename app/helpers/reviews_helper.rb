module ReviewsHelper
  def choose_new_or_edit
    if action_name == 'new'
      prot_reviews_path(params[:prot_id])
    elsif action_name == 'edit'
      prot_review_path(params[:prot_id])
    end
  end
end
