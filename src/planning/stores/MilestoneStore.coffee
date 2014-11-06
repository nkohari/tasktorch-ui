_     = require 'lodash'
Store = require '../../framework/Store'

class MilestoneStore extends Store

  constructor: ->
    @milestones = {}

  onMilestonesLoaded: (event) ->
    @milestones = _.extend @milestones, _.indexBy(event.milestones, 'id')
    @announce()

module.exports = MilestoneStore
