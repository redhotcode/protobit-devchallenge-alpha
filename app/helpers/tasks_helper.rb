module TasksHelper

  MUTED_TEXT_CLASS = 'text-muted'
  EMPTY_CLASS_ATTR = ''

  # Utility method to elegantly set the active CSS classes for a given task's
  # row, using the standard Bootstrap utility classes.
  ### Style completed tasks
  def task_row_classes(task)
    if task.complete && task.complete == true
      MUTED_TEXT_CLASS
    else
      EMPTY_CLASS_ATTR
    end
  end
end
