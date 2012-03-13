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
      dataType: "json"
      url: "/entries/" + id + "/vote"
      data:
        direction: $(this).data("direction")
      success: (data) =>
        $(this).siblings().removeClass("selected")
        $(this).addClass("selected")
    false

  $(".response a.tag").click ->
    id = $(this).parents(".entry-container").data("id")
    tag = $(this).data("tag")
    $.ajax
      type: "post"
      dataType: "json"
      url: "/entries/" + id + "/tag_vote"
      data:
        tag: tag
      success: (data) =>
        if data.persisted
          $(this).addClass("selected")
        else
          $(this).removeClass("selected")
    false


  $("#new_comment").ajaxForm
    dataType: 'json'
    resetForm: true
    success: (data) ->
      $("#comments").append(data.html)
    error: (xhr) ->
      console.log xhr


