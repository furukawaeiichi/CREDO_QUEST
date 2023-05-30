class TodosController < ApplicationController
  before_action :set_todo, only: %i[update]
  before_action :authorize_user, only: [:update]

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.turbo_stream
        format.html { redirect_to @todo.list, notice: "クエストが更新されました！" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:checked)
  end

  def authorize_user
    unless current_user == @todo.user
      redirect_to @todo.list, alert: "権限がありません"
    end
  end
end
