class Preview::NodesController < ApplicationController

  # GET /nodes
  # GET /nodes.json
  def index
    @prot = Prot.find(params[:prot_id])
    @nodes = @prot.nodes.all.order(position: :asc)
  end
end
