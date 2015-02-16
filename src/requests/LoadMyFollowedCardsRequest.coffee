superagent        = require 'superagent'
Request           = require 'framework/Request'
CardsLoadedEvent  = require 'events/load/CardsLoadedEvent'
NotesLoadedEvent  = require 'events/load/NotesLoadedEvent'
UsersLoadedEvent  = require 'events/load/UsersLoadedEvent'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'
TeamsLoadedEvent  = require 'events/load/TeamsLoadedEvent'

class LoadMyFollowedCardsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/me/following?expand=notes,owner,stack,stack.user,stack.team", (res) =>
      {cards} = res.body
      {notes, stacks, teams, users} = res.body.related
      eventBus.publish new CardsLoadedEvent(cards)
      eventBus.publish new NotesLoadedEvent(notes)  if notes?.length > 0
      eventBus.publish new StacksLoadedEvent(notes) if stacks?.length > 0
      eventBus.publish new TeamsLoadedEvent(notes)  if teams?.length > 0
      eventBus.publish new UsersLoadedEvent(users)  if users?.length > 0

module.exports = LoadMyFollowedCardsRequest
