# frozen_string_literal: true

class NodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_node, only: %i[show edit update destroy]
  before_action :author_check

  def index
    @prot = current_user.prots.find(params[:prot_id])
    @nodes = @prot.nodes.all.order(position: :asc)
    @node = @prot.nodes.first
  end

  def show; end

  def new
    @node = Node.new
  end

  def edit; end

  def create
    @prot = current_user.prots.find(params[:prot_id])
    if @prot.nodes.length.zero?
      @node = @prot.nodes.build(title: 'new title', body: '本文', position: 0, parent_id: nil)
    else
      @node = Node.new(node_params)
    end

    respond_to do |format|
      if @node.save
        format.html { redirect_to prot_nodes_path(@prot), notice: 'ルートノードを作成しました' }
        format.json { render :show, status: :created, location: [@prot, @node] }
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @prot = current_user.prots.find(params[:prot_id])
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to prot_nodes_path(@prot), notice: '本文の編集に成功しました！' }
        format.json { render :show, status: :ok, location: [@prot, @node] }
      else
        format.html { render :index }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_node
    @prot = current_user.prots.find(params[:prot_id])
    @node = @prot.nodes.find(params[:id])
  end

  def author_check
    raise StandardError if current_user.prots.find(params[:prot_id]).user_id != current_user.id
  end

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
