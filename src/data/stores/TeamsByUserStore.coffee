_                      = require 'lodash'
StackType              = require 'data/enums/StackType'
ListStore              = require 'data/framework/ListStore'
LoadTeamsByUserRequest = require 'data/requests/LoadTeamsByUserRequest'

class TeamsByUserStore extends ListStore

  displayName: 'TeamsByUserStore'
  name:        'teamsByUser'
  dependsOn:   'teams'

  listensFor: [
    'TeamsByUserLoaded'
    'TeamChanged'
  ]

  load: (userid) ->
    @execute new LoadTeamsByUserRequest(userid)

  onTeamsByUserLoaded: (event) ->
    @set(event.userid, _.map(event.teams, 'id'))

  onTeamChanged: (event) ->
    for userid, list of @lists
      @remove(userid) if _.includes(list, event.team.id)

module.exports = TeamsByUserStore
