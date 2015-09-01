_                          = require 'lodash'
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

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/me/following?expand=user,team,stack"))
    .withCredentials()
  
  onSuccess: (result, publish) ->

    cards  = _.map result.cards,           (doc) -> new Card(doc)
    stacks = _.map result.related?.stacks, (doc) -> new Stack(doc)
    teams  = _.map result.related?.teams,  (doc) -> new Team(doc)
    users  = _.map result.related?.users,  (doc) -> new User(doc)

    publish new CardsLoadedEvent(cards)
    publish new StacksLoadedEvent(stacks) if stacks?.length > 0
    publish new TeamsLoadedEvent(teams)   if teams?.length > 0
    publish new UsersLoadedEvent(users)   if users?.length > 0

    publish new MyFollowedCardsLoadedEvent(cards)

module.exports = LoadMyFollowedCardsRequest
