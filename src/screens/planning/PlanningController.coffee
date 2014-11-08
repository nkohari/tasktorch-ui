_                     = require 'lodash'
request               = require 'superagent'
Controller            = require 'framework/Controller'
GoalsLoadedEvent      = require 'events/GoalsLoadedEvent'
MilestonesLoadedEvent = require 'events/MilestonesLoadedEvent'

class PlanningController extends Controller

  constructor: (@organizationId, eventBus, stores) ->
    super(eventBus, stores)

  loadGoals: ->
    request.get "/api/#{@organizationId}/goals", (res) =>
      @publish new GoalsLoadedEvent(res.body)

  loadMilestonesInGoal: (goalId) ->
    request.get "/api/#{@organizationId}/goals/#{goalId}/milestones", (res) =>
      @publish new MilestonesLoadedEvent(res.body)

module.exports = PlanningController
