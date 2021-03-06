class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new #only cares about showing the form
    @task = Task.new
  end

  def create # has access to user data, from the form
    # puts params
    task = Task.new(name: params[:task][:name], description: params[:task][:description], due_date: params[:task][:due_date])
    task.save
    redirect_to('/tasks')

    # can also do
    # task = Task.new
    # task.name = params[:task][:name]
    # task.description = params[:task][:description]
    # book.save
  end

  def show
    @task = Task.find (params[:id])
  end

  def edit #i am assuming this will work like new, ehree the update is what matters
    @task = Task.find (params[:id]) #needs to be instance variable; won't work if local variable
  end

  def update

    @task = Task.find (params[:id])
    task_updates = params.require(:task).permit(:name, :description, :due_date, :complete)
    @task.update_attributes(task_updates) #don't know how to use this right now
    @task.save

    if params[:refresh]
      redirect_to tasks_path
    else
      redirect_to task_path(@task)
    end

  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path
  end

end
