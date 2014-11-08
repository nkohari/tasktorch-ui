PlanningController = require './PlanningController'
GoalStore          = require './stores/GoalStore'
MilestoneStore     = require './stores/MilestoneStore'

PlanningControllerFactory = {}

PlanningControllerFactory.create = (organizationId, eventBus) ->

  new PlanningController(organizationId, eventBus, {
    goals:      new GoalStore()
    milestones: new MilestoneStore()
  })

module.exports = PlanningControllerFactory
