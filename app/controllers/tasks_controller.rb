class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    # raise
    if params[:by_deadline] == "true"
      @tasks = current_user.tasks.all.order('expired_at DESC').page params[:page]
    elsif params[:by_priority] == "true"
      @tasks = current_user.tasks.all.order('priority DESC').page params[:page]
    else
      @tasks = current_user.tasks.all.order('created_at DESC').page params[:page]
    end
  end

  def show
  end

  def new
    redirect_to tasks_path if current_user
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # p current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task , notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  # def search
  #   session[:search] = {'name' => params[:search_title], 'status' => params[:search_status], 'priority' => params[:search_priority]}
  #   if params[:search_title].present?
  #     if params[:search_status].present?
  #       if params[:search_priority].present?
  #         @tasks = Task.all.title_search(params[:search_title]).order_by_status(params[:search_status]).order_by_priority(params[:search_priority])
  #       else
  #         @tasks = Task.all.title_search(params[:search_title]).order_by_status(params[:search_status])
  #       end
  #     elsif params[:search_priority].present?
  #       @tasks = Task.all.title_search(params[:search_title]).order_by_priority(params[:search_priority])
  #     else
  #       @tasks = Task.all.title_search(params[:search_title])

  #     end
  #   elsif params[:search_status].present?
      
  #     if params[:search_priority].present?
  #       @tasks = Task.all.order_by_status(params[:search_status]).order_by_priority(params[:search_priority])
  #     else
  #       @tasks = Task.all.order_by_status(params[:search_status])
  #     end
  #   elsif params[:search_priority].present?
      
  #     if params[:search_status].present?
  #       @tasks = Task.all.order_by_priority(params[:search_priority]).order_by_status(params[:search_status])
  #     else
  #       @tasks = Task.all.order_by_priority(params[:search_priority])
  #     end
  #   else
  #     @tasks = Task.all
  #   end
  #   # @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  #   render :index
  # end


  def search 
    session[:search] = {'name' => params[:search_title], 'status' => params[:search_status], 'priority' => params[:search_priority]}
   
    if params[:search_title].present?
      if params[:search_status].present?
        if params[:search_priority].present?
          @tasks = Task.all.title_search(params[:search_title]).order_by_status(params[:search_status]).order_by_priority(params[:search_priority]).page params[:page] 
        else
          @tasks = Task.all.title_search(params[:search_title]).order_by_status(params[:search_status]).page params[:page] 
        end
      elsif params[:search_priority].present?
        @tasks = Task.all.title_search(params[:search_title]).order_by_priority(params[:search_priority]).page params[:page] 
      else
        @tasks = Task.all.title_search(params[:search_title]).page params[:page] 

      end
    elsif params[:search_status].present?
      
      if params[:search_priority].present?
        @tasks = Task.all.order_by_status(params[:search_status]).order_by_priority(params[:search_priority]).page params[:page] 
      else
        @tasks = Task.all.order_by_status(params[:search_status]).page params[:page] 
      end
    elsif params[:search_priority].present?
      
      if params[:search_status].present?
        @tasks = Task.all.order_by_priority(params[:search_priority]).order_by_status(params[:search_status]).page params[:page] 
      else
        @tasks = Task.all.order_by_priority(params[:search_priority]).page params[:page] 
      end
    else
      @tasks = Task.all
    end
  
    # @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
    
    render :index
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end


    def task_params
      params.require(:task).permit(:name, :details, :expired_at, :status, :priority)
    end

    def require_login
      unless current_user
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_session_path
      end
    end
end
