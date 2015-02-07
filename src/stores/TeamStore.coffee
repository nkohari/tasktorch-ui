_                  = require 'lodash'
Store              = require 'framework/Store'
LoadTeamRequest    = require 'requests/LoadTeamRequest'
LoadMyTeamsRequest = require 'requests/LoadMyTeamsRequest'

class TeamStore extends Store

  displayName: 'TeamStore'

  getAllByMember: (userid) ->
    _.filter @items, (team) -> _.contains(team.members, userid)

  onTeamDisplayed: (event) ->
    if @get(event.teamid)?
      @announce()
    else
      @execute new LoadTeamRequest(event.teamid)

  onMyTeamsDisplayed: (event) ->
    @execute new LoadMyTeamsRequest()

  onTeamsLoaded: (event) ->
    @add(event.teams)

  onTeamCreated: (event) ->
    @add(event.team)

  onTeamDeleted: (event) ->
    @remove(event.team)

  onTeamChanged: (event) ->
    @add(event.team)

module.exports = TeamStore
