# frozen_string_literal: true

class Preview::NodesController < ApplicationController
  before_action :private_protect
  # GET /nodes
  # GET /nodes.json
  def index
    @prot = Prot.find(params[:prot_id])
    @nodes = @prot.nodes.all.order(position: :asc)
  end

  private

  def private_protect
    prot = Prot.find(params[:prot_id])
    raise StandardError if prot.private == true && prot.user_id != current_user.id
  end
end
