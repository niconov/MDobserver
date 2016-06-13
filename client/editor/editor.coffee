converter = new Showdown.converter()

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
  name: ->
    if @name
      return @name
    else
      return undefined
  _id: ->
    if @_id
      return @_id
    else
      return undefined



Template.editor.events
  "submit form": (e, t) ->
    e.preventDefault()
    console.log new Date

    Files.upsert _id: t.find('#id').value,
      name: t.find('#name').value
      text: t.find('textarea').value
      updatedAt: new Date()

  "input #mdInput": (e) ->
    text = e.target.value
    html = converter.makeHtml text
    $('.markdown#textOutput').html html
