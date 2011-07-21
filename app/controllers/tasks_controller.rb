class TasksController < ApplicationController
  def index
    @tasks = Task.undone.paginate(:page => params[:page], :per_page => 5)
  end

  def done
    @tasks = Task.done.paginate(:page => params[:page], :per_page => 5)
    render :index
  end

  def search
    @tasks = Task.undone
    @tasks = @tasks.search(params[:query]) if params[:query].present?
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 5)
    render :index
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.create(params[:task])
    redirect_to @task
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes params[:task]
    redirect_to @task
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
end
