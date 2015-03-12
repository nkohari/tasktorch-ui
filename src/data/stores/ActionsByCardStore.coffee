_                        = require 'lodash'
ListStore                = require 'data/framework/ListStore'
LoadActionsByCardRequest = require 'data/requests/LoadActionsByCardRequest'

class ActionsByCardStore extends ListStore

  displayName: 'ActionsByCardStore'
  name:        'actionsByCard'
  dependsOn:   'actions'

  listensFor: [
    'ActionsByCardLoaded'
    'CardChanged'
  ]

  load: (id) ->
    @execute new LoadActionsByCardRequest(id)

  onActionsByCardLoaded: (event) ->
    @set(event.cardid, _.pluck(event.actions, 'id'))

  onCardChanged: (event) ->
    actionids = _.flatten _.values(event.card.actions)
    @set(event.card.id, actionids)

module.exports = ActionsByCardStore
