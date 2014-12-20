_     = require 'lodash'
Store = require 'framework/Store'

class MilestoneStore extends Store

  onMilestonesLoaded: (event) ->
    @add(event.milestones)

module.exports = MilestoneStore
