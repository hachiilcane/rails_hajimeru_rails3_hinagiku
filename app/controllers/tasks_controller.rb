class TasksController < ApplicationController
  before_filter :prepare, :only => [ :index, :done ]

  def index
    @tasks = @tasks.undone.paginate(:page => params[:page], :per_page => 5)
  end

  def done
    @tasks = @tasks.done.paginate(:page => params[:page], :per_page => 5)
    render :index
  end

  def search
    @tasks = Task.undone
    @tasks = @tasks.search(params[:query]) if params[:query].present?
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 5)
    render :index
  end

  def show
    begin
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render "errors/not_found", :status => 404
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes params[:task]
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to :tasks
  end

  def finish
    @task = Task.find(params[:id])
    @task.update_attributes(:done => true)
    redirect_to :back
  end

  def restart
    @task = Task.find(params[:id])
    @task.update_attributes(:done => false)
    redirect_to :back
  end

  private

  def prepare
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @tasks = @category.tasks.done
    else
      @tasks = Task
    end
  end
end
