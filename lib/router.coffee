Router.configure
  layoutTemplate: "template"

Router.map ->

  @route "home",
    name:"home"
    path:"/"

  @route 'editor',
    name: 'editor'
    path: "/editor/:_id"
    waitOn: ->
      return Meteor.subscribe 'Files'
    data: ->
      unless @params._id is 'new'
        return Files.findOne _id: @params._id

  @route 'files',
    name: 'files'
    path: "/files"
    waitOn: ->
      return Meteor.subscribe 'Files'
