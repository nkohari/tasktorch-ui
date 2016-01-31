_                          = require 'lodash'
ListStore                  = require 'data/framework/ListStore'
LoadFollowersByCardRequest = require 'data/requests/LoadFollowersByCardRequest'

class FollowersByCardStore extends ListStore

  displayName: 'FollowersByCardStore'
  name:        'followersByCard'
  dependsOn:   'users'

  listensFor: [
    'CardChanged'
    'FollowersByCardLoaded'
  ]

  load: (id) ->
    @execute new LoadFollowersByCardRequest(id)

  onCardChanged: (event) ->
    @set(event.card.id, event.card.followers)

  onFollowersByCardLoaded: (event) ->
    @set(event.cardid, _.map(event.users, 'id'))

module.exports = FollowersByCardStore
