_                         = require 'lodash'
ListStore                 = require 'data/framework/ListStore'
LoadSuggestedTeamsRequest = require 'data/requests/LoadSuggestedTeamsRequest'

class SuggestedTeamsStore extends ListStore

  displayName: 'SuggestedTeamsStore'
  name:        'suggestedTeams'
  dependsOn:   'teams'

  listensFor: [
    'SuggestedTeamsLoaded'
  ]

  load: (id) ->
    @execute new LoadSuggestedTeamsRequest(id)

  onSuggestedTeamsLoaded: (event) ->
    @set(event.phrase, _.map(event.teams, 'id'))

module.exports = SuggestedTeamsStore
