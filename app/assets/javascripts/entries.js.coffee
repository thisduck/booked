# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".response a.back").click ->
    window.history.back()
    false

  set_response = (event) ->
    windowHeight = $(window).height()
    $box = $('.response')
    $parent = $box.parent()
    parentAbsoluteTop = $parent.offset().top
    parentAbsoluteLeft = $parent.offset().left
    parentAbsoluteRight = parentAbsoluteLeft + $parent.width()
    parentAbsoluteBottom = parentAbsoluteTop + $parent.height()
    topStop = parentAbsoluteTop + $box.height()
    windowWidth = $(window).width()
    boxRight = windowWidth - parentAbsoluteRight

    windowBottom = $(window).scrollTop() + windowHeight

    if windowBottom < topStop
      $box.css
        position: 'absolute'
        top: '0px'
        bottom: 'auto'
        right: 0
    else if windowBottom >= topStop && windowBottom <= parentAbsoluteBottom
      $box.css
        position: 'fixed'
        top: 'auto'
        bottom: '2em'
        right: boxRight
    else 
      $box.css
        position: 'absolute'
        top: 'auto'
        bottom: '0px'
        right: 0

  set_response()
  $(window).scroll set_response
