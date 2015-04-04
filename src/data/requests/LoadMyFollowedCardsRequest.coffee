_                          = require 'lodash'
superagent                 = require 'superagent'
Card                       = require 'data/models/Card'
Stack                      = require 'data/models/Stack'
Team                       = require 'data/models/Team'
User                       = require 'data/models/User'
CardsLoadedEvent           = require 'events/load/CardsLoadedEvent'
UsersLoadedEvent           = require 'events/load/UsersLoadedEvent'
StacksLoadedEvent          = require 'events/load/StacksLoadedEvent'
TeamsLoadedEvent           = require 'events/load/TeamsLoadedEvent'
MyFollowedCardsLoadedEvent = require 'events/load/MyFollowedCardsLoadedEvent'
Request                    = require 'data/framework/Request'

class LoadMyFollowedCardsRequest extends Request

  execute: (eventQueue) ->
    
    superagent.get "/api/#{Environment.orgid}/me/following?expand=user,team,stack", (res) =>

      cards  = _.map res.body.cards,          (doc) -> new Card(doc)
      stacks = _.map res.body.related.stacks, (doc) -> new Stack(doc)
      teams  = _.map res.body.related.teams,  (doc) -> new Team(doc)
      users  = _.map res.body.related.users,  (doc) -> new User(doc)

      eventQueue.publish new CardsLoadedEvent(cards)
      eventQueue.publish new StacksLoadedEvent(stacks) if stacks.length > 0
      eventQueue.publish new TeamsLoadedEvent(teams)  if teams.length > 0
      eventQueue.publish new UsersLoadedEvent(users)  if users.length > 0

      eventQueue.publish new MyFollowedCardsLoadedEvent(cards)

module.exports = LoadMyFollowedCardsRequest
