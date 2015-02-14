superagent       = require 'superagent'
Request          = require 'framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'
NotesLoadedEvent = require 'events/load/NotesLoadedEvent'

class LoadMyFollowedCardsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/me/following?expand=notes", (res) =>
      {cards} = res.body
      {notes} = res.body.related
      eventBus.publish new CardsLoadedEvent(cards)
      eventBus.publish new NotesLoadedEvent(notes)

module.exports = LoadMyFollowedCardsRequest
