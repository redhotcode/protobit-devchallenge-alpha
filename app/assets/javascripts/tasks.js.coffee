MUTED_TEXT_CLASSNAME = "text-muted"
# Notify the user that a task has been successfully marked as complete, stylizing the object appropriately, after
# the operation has been performed remotely.
$(document).on 'ajax:complete', '.task-completion', (e,x,o) ->
  console.log "TODO: Alert user of task completion"
  ## Style completed tasks
  if this.checked
    $(this).parent().parent().addClass(MUTED_TEXT_CLASSNAME)
  else
    $(this).parent().parent().removeClass(MUTED_TEXT_CLASSNAME)


# Notify the user that a task has been archived, and hide that row from the table, assuming the operation
# has been performed remotely.
$(document).on 'ajax:complete', '.task-archival', (e,x,o) ->
  console.log "TODO: Alert user of task archival"
  $(this).parents('tr').remove()