# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".response a.back").click ->
    window.history.back()
    false

  $(".response .vote a").click ->
    id = $(this).parents(".entry-container").data("id")
    $.ajax
      type: "post"
      url: "/entries/" + id + "/vote"
      data:
        direction: $(this).data("direction")
      success: (data) =>
        $(this).siblings().removeClass("selected")
        $(this).addClass("selected")
    false
