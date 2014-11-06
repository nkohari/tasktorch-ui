PlanningController = require './PlanningController'
GoalStore          = require './stores/GoalStore'
MilestoneStore     = require './stores/MilestoneStore'

PlanningEnvironment = {}

PlanningEnvironment.createController = ->

  stores =
    goals:      new GoalStore()
    milestones: new MilestoneStore()

  return new PlanningController(stores)

module.exports = PlanningEnvironment
