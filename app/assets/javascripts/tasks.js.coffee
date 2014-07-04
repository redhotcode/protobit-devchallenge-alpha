# You can use Javascript in tasks_javascript.js if you'd rather.
$(document).on 'ajax:complete', '.task-completion', (e,x,o) ->
  console.log "I will do something here to notifiy the user that an operation has completed."
  console.log this.getAttribute("data-task-id")
$(document).on 'ajax:complete', '.task-archival', (e,x,o) ->
  console.log "I will do something here to notify the user that an archive operation has been completed."