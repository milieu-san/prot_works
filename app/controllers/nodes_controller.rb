class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    @prot = Prot.find(params[:prot_id])
    @nodes = @prot.nodes.all.order(position: :asc)
    @node = @prot.nodes.first
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    # edit ボタンでノードをロードする。いらない？
    # respond_to do |format|
    #   format.json {
    #     @node = Node.find(params[:id])
    #     render nodes_path
    #   }
    # end
  end

  # GET /nodes/new
  def new
    @node = Node.new
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @prot = Prot.find(params[:prot_id])
    @node = @prot.nodes.build(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_to prot_node_path(@prot,@node), notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: [@prot, @node] }
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    @prot = Prot.find(params[:prot_id])
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to prot_nodes_path(@prot), notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: [@prot, @node] }
      else
        format.html { render :index }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @prot = Prot.find(params[:prot_id])
      @node = @prot.nodes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node)
            .permit(:title,
                    :body,
                    :parent_id,
                    :prot_id,
                    :position,
                    :new_position)
    end
end
