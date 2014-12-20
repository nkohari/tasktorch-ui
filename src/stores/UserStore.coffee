_                             = require 'lodash'
Store                         = require 'framework/Store'
LoadUserRequest               = require 'requests/LoadUserRequest'
LoadParticipantsByCardRequest = require 'requests/LoadParticipantsByCardRequest'

class UserStore extends Store

  constructor: ->
    super()
    @currentUser = undefined

  getCurrentUser: ->
    @currentUser

  onUserDisplayed: (event) ->
    if @get(event.userId)?
      @announce()
    else
      @execute new LoadUserRequest(event.userId)

  onCardParticipantListDisplayed: (event) ->
    if @getMany(event.userIds)?
      @announce()
    else
      @execute new LoadParticipantsByCardRequest(event.cardId)

  onUsersLoaded: (event) ->
    @add(event.users)

  onCurrentUserLoaded: (event) ->
    if not @currentUser? or event.user.version > @currentUser.version
      @currentUser = event.user
      @announce()

module.exports = UserStore
