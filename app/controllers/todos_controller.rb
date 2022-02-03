class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  rescue_from (ActiveRecord::RecordNotFound) { |exception| handle_exception(exception, 404) }

  # GET /todos or /todos.json
  def index
    @todos = Todo.all.order(:completed)
    @todoscompleted = Todo.where(completed: true).order(:completed)
    @todostodo = Todo.where(completed: not(true)).order(:completed)
    
    # @customtodos = Todo.where('title ~* ?', params[:search].to_s)
    # @customtodos = Todo.where("title like ?", "%#{params[:search]}%")
  end
  
  def search
    @customtodos = Todo.where("title LIKE ? OR description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    @query = params[:q].to_s
  end
  

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    #@todo = Todo.new
    @todo = current_user.todos.build
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    #@todo = Todo.new(todo_params)
    @todo = current_user.todos.build(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_path }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def correct_user
    @todo = current_user.todos.find_by(id: params[:id])
  end
  
  # Method gets triggered when an exception is raised.
  def handle_exception(ex, status)
    render_404
  end
  
  def render_404
    respond_to do |format|
      format.html { render :file => Rails.root.join('public/404.html'), :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through. Completed needs to default to false to be able to use the nav tabs on the index page
    def todo_params
      params.require(:todo).permit(:title, :description, :completed, :user_id, :q).with_defaults(completed: false, q: "")
    end
end
