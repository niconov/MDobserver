Meteor.publish "Files", ->
  return Files.find()
