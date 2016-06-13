Template.files.helpers
  files: ->
    return Files.find()
  time: ->
    options =
      year: 'numeric',
      month: 'long',
      day: 'numeric',

    return @updatedAt.toLocaleString("ru", options)

Template.files.events
  "click #markAsDeleted": (e, t) ->
    fileId = $(e.target).attr 'data-file-mark-as-deleted'
    Files.update _id: fileId,
      $set: deleted: true
