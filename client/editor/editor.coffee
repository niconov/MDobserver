Template.editor.rendered = ->
  _id = Router.current().params._id
  unless _id is 'new'
    file = Files.findOne(_id: _id)
    text = file.text
    html = converter.makeHtml file.text
    @data = file

  else
    text = ''
    html = ''

  $('textarea#mdInput').text text
  $('.markdown#textOutput').html html


Template.editor.helpers
  editorShowResult: ->
    return Session.get 'editorShowResult'

Template.editor.events
  "click #editorShowResult": () ->
    Session.set 'editorShowResult', !(Session.get 'editorShowResult')
    state = Session.get 'editorShowResult'
    if state
      $('#textOutput').css 'display', 'none'
    else
      $('#textOutput').css 'display', 'block'


    convert()

  "input #mdInput": (e) ->
    update()
    convert()
  "input #name": ->
    update()

update = ->
  unless $('#id').val() is undefined
    Files.upsert _id: $('#id').val(),
      name: $('#name').val()
      text: $('textarea#mdInput').val()
      updatedAt: new Date()

convert = ->
  html = converter.makeHtml $('textarea#mdInput').val()
  $('#textOutput').html html


timeFormat =
  hour: 'numeric',
  minute: 'numeric',
  second: 'numeric'
  year: 'numeric',
  day: 'numeric'
  month: 'long'

converter = new Showdown.converter()
