class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.order(id: :desc).all
    @task = Task.new
    @like = Like.new
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @list = current_user.lists.find_or_create_by(title: "マイクエスト")
    @task = @list.tasks.build(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to request.referrer, notice: "クエストが作成されました！一緒にがんばるぞ！" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to request.referrer, notice: "クエストが更新されました！" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.likes.destroy_all
    @task.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "クエストが削除されました！", status: :see_other }
    end
  end

  def ranking
    three_months_ago = 3.months.ago
    @tasks = Task.left_joins(:likes)
                  .where('tasks.created_at > ?', three_months_ago)
                  .group(:id)
                  .order('COUNT(likes.id) DESC, tasks.created_at ASC')
                  .limit(10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:content, :checked)
    end

    # Verify that the current user is the owner of the task
    def authenticate_user
      unless current_user == @task.user
        redirect_to request.referrer, alert: "権限がありません"
      end
    end
end
