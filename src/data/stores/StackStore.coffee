_                   = require 'lodash'
Store               = require 'framework/Store'
LoadStackRequest    = require 'requests/LoadStackRequest'
LoadMyStacksRequest = require 'requests/LoadMyStacksRequest'

class StackStore extends Store

  displayName: 'StackStore'

  getSpecialStackByUser: (userid, type) ->
    _.find @items, (stack) -> stack.user? and stack.user == userid and stack.type == type

  getAllByUser: (userid) ->
    _.filter @items, (stack) -> stack.user? and stack.user == userid

  getAllByTeam: (teamid) ->
    _.filter @items, (stack) -> stack.team? and stack.team == teamid

  onStackDisplayed: (event) ->
    if @get(event.stackid)?
      @announce()
    else
      @execute new LoadStackRequest(event.stackid)

  onMyStacksDisplayed: (event) ->
    @execute new LoadMyStacksRequest()

  onTeamStackListDisplayed: (event) ->
    # TODO: This does nothing at the moment because stacks are expanded
    # in LoadMyTeamsRequest.

  onStacksLoaded: (event) ->
    @add(event.stacks)

  onStackCreated: (event) ->
    @add(event.stack)

  onStackDeleted: (event) ->
    @remove(event.stack)

  onStackChanged: (event) ->
    @add(event.stack)

module.exports = StackStore
