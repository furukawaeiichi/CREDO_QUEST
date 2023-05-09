class TodosController < ApplicationController
  before_action :set_list

  def create
    todo = @list.todos.new(content: params[:todo][:content])
    if todo.save
      redirect_to boards_path, notice: 'Todoが作成されました'
    else
      redirect_to boards_path, alert: 'Todoの作成に失敗しました'
    end
  end

  private

  def set_list
    @list = current_user.lists.find_by(title: "マイクエスト")
    if @list.nil?
      @list = current_user.lists.create(title: "マイクエスト")
    end
  end

  def index
    list = current_user.lists.find_by(title: "マイクエスト")
    @todos = list.todos if list
  end
end
