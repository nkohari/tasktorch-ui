_                  = require 'lodash'
Store              = require 'framework/Store'
LoadTeamRequest    = require 'requests/LoadTeamRequest'
LoadMyTeamsRequest = require 'requests/LoadMyTeamsRequest'

class TeamStore extends Store

  displayName: 'TeamStore'

  getAllByMember: (userId) ->
    _.filter @items, (team) -> _.contains(team.members, userId)

  onTeamDisplayed: (event) ->
    if @get(event.teamId)?
      @announce()
    else
      @execute new LoadTeamRequest(event.teamId)

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
