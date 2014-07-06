class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete, :archive]

  # GET /tasks
  # GET /tasks.json
  def index
    @task = Task.new
    @query = nil
    if params.key?('q')
      @archived = nil
      @query = params['q']

      @tasks = Task.where(
        Task.arel_table[:title].matches("%#{@query}%").or(
          Task.arel_table[:description].matches("%#{@query}%")
        )
      )
    else
      @tasks = Task.all

      @archived = params.key?('archived') && params['archived'] == 'true'
      @tasks.where!(archived: true) if @archived
      @tasks = @tasks.unarchived unless @archived
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  # GET /tasks/1/complete
  # GET /tasks/1/complete.json
  # Set the completion status of a given task.
  ### Add complete support
  def complete
    @task.complete = !(params[:task_complete].nil?)
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url }
        format.json { head :no_content }
      else
        flash[:error] = "Could not complete task!"
        format.html { redirect_to tasks_url }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    ### Add Twitter Integration
    if @task.complete
      TWITTER_CLIENT.update(twitter_message_for @task )
    end
  end

  # GET /tasks/1/archive
  # GET /tasks/1/archive.json
  # Set the archive attribute of a given task
  ### Add archive support
  def archive
    @task.archived = true
    respond_to do |format|
      if @task.save
        flash[:notice] = "Task archived succcessfully! (Task ###{@task.id})"
        format.html { redirect_to tasks_url }
        format.json { head :no_content }
      else
        flash[:error] = "Could not archive task!"
        format.html { redirect_to tasks_url }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :complete, :archived, :tags)
    end

    def twitter_message_for(task)
      message = "'$' was marked complete."
      if task.title.length > (TWITTER_MAX_LENGTH - message.gsub('$','').length)
        message.gsub! '$', "%s...%s"
        lastWord = task.title.split.last
        firstBit = task.title.slice(0,
                    TWITTER_MAX_LENGTH - message.gsub("%s",'').length - lastWord.length)
        return message % [firstBit, lastWord]
      else
        return message.gsub('$', task.title)
      end
    end

end
