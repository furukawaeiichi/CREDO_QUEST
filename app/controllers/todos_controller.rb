class TodosController < ApplicationController
  before_action :set_todo, only: %i[update]
  before_action :authorize_user, only: [:update]

  def update
    @list = @todo.list
    if @todo.update(todo_params)
      @user = @list.user
      @level = @user.level
      flash.now.notice = "公式クエストを更新しました！"
    else
      render :edit, status: :unprocessable_entity
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
