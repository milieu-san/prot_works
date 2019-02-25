# frozen_string_literal: true

module StarsHelper
  def star_giving?(other_user_id)
    current_user.giving_stars.find_by(take_user_id: other_user_id)
  end
end
