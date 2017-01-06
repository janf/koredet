ready = ->
  @alert("Welcome to the world of Coffeescript")
 
$(document).ready(ready)
$(document).on('turbolinks:load', ready)