$(document).on "turbolinks:load", () ->
  $(".notification_row").click ->
    $("##{$(this).attr("id")} div.body").toggle()
