_                        = require 'lodash'
ListStore                = require 'data/framework/ListStore'
LoadMembersByTeamRequest = require 'data/requests/LoadMembersByTeamRequest'

class MembersByTeamStore extends ListStore

  displayName: 'MembersByTeamStore'
  name:        'membersByTeam'
  dependsOn:   'users'

  listensFor: [
    'MembersByTeamLoaded'
  ]

  load: (id) ->
    @execute new LoadMembersByTeamRequest(id)

  onMembersByTeamLoaded: (event) ->
    @set(event.teamid, _.pluck(event.users, 'id'))

module.exports = MembersByTeamStore
