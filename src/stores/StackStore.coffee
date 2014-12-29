_                   = require 'lodash'
Store               = require 'framework/Store'
LoadStackRequest    = require 'requests/LoadStackRequest'
LoadMyStacksRequest = require 'requests/LoadMyStacksRequest'

class StackStore extends Store

  getAllByOwner: (userId) ->
    _.filter @items, (stack) -> stack.owner? and stack.owner == userId

  getAllByTeam: (teamId) ->
    _.filter @items, (stack) -> stack.team? and stack.team == teamId

  onStackDisplayed: (event) ->
    if @get(event.stackId)?
      @announce()
    else
      @execute new LoadStackRequest(event.stackId)

  onMyStacksDisplayed: (event) ->
    @execute new LoadMyStacksRequest()

  onTeamStackListDisplayed: (event) ->
    # TODO: This does nothing at the moment because stacks are expanded
    # in LoadMyTeamsRequest.

  onStacksLoaded: (event) ->
    @add(event.stacks)

  onStackChanged: (event) ->
    @add(event.stack)

module.exports = StackStore
