module UsersHelper
  def checked_todos_count(list_title)
    list = List.find_by(title: list_title)
    list.todos.where(checked: true).count
  end

  def list_bar_color(title)
    case title
    when "Be Open"
      "bg-primary"
    when "Move Fast"
      "bg-success"
    when "Give First"
      "bg-info"
    when "Geek Out"
      "bg-warning"
    when "Take Ownership"
      "bg-danger"
    else
      "bg-secondary"
    end
  end

  def progress_percentage(list)
    (checked_todos_count(list.title).to_f / list.todos.count.to_f) * 100
  end
end
