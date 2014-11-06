_                     = require 'lodash'
request               = require 'superagent'
Controller            = require '../framework/Controller'
GoalsLoadedEvent      = require '../events/GoalsLoadedEvent'
MilestonesLoadedEvent = require '../events/MilestonesLoadedEvent'

class PlanningController extends Controller

  setOrganization: (organizationId) ->
    @organizationId = organizationId

  loadGoals: ->
    request.get "/api/#{@organizationId}/goals", (res) =>
      @dispatch new GoalsLoadedEvent(res.body)

  loadMilestonesInGoal: (goalId) ->
    request.get "/api/#{@organizationId}/goals/#{goalId}/milestones", (res) =>
      @dispatch new MilestonesLoadedEvent(res.body)

module.exports = PlanningController
