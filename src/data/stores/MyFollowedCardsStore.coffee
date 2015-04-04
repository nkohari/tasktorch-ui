_                          = require 'lodash'
SingletonListStore         = require 'data/framework/SingletonListStore'
LoadMyFollowedCardsRequest = require 'data/requests/LoadMyFollowedCardsRequest'

class MyFollowedCardsStore extends SingletonListStore

  displayName: 'MyFollowedCardsStore'
  name:        'myFollowedCards'
  dependsOn:   'cards'

  listensFor: [
    'MyFollowedCardsLoaded'
    'CardChanged'
  ]

  load: ->
    @execute new LoadMyFollowedCardsRequest()

  onMyFollowedCardsLoaded: (event) ->
    @set(_.pluck(event.cards, 'id'))

  onCardChanged: (event) ->
    @clear()

module.exports = MyFollowedCardsStore
