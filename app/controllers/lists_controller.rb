class ListsController < ApplicationController
  def boards
    @todos = Todo.all
    render "boards/index"
  end
end
