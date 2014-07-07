# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  answer = $('#answer-tmpl').html();

  $('#add-new-answer').on "click", () ->
    $('#answers').append answer.replace /\*\*id\*\*/g, $('.answer-item').length
