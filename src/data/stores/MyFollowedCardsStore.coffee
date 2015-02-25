_                          = require 'lodash'
SingletonListStore         = require 'data/framework/SingletonListStore'
LoadMyFollowedCardsRequest = require 'data/requests/LoadMyFollowedCardsRequest'

class MyFollowedCardsStore extends SingletonListStore

  displayName: 'MyFollowedCardsStore'
  name:        'myFollowedCards'
  dependsOn:   'cards'

  listensFor: [
    'MyFollowedCardsLoaded'
    'UserFollowedCard'
    'UserUnfollowedCard'
  ]

  load: ->
    @execute new LoadMyFollowedCardsRequest()

  onMyFollowedCardsLoaded: (event) ->
    @set(_.pluck(event.cards, 'id'))

  onUserFollowedCard: (event) ->
    # TODO

  onUserUnfollowedCard: (event) ->
    # TODO

module.exports = MyFollowedCardsStore
