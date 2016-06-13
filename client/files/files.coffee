Template.files.helpers
  files: ->
    return Files.find()
  time: ->
    options =
      year: 'numeric',
      month: 'long',
      day: 'numeric',

    return @updatedAt.toLocaleString("ru", options)
