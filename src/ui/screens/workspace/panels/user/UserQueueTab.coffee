#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
{div}       = React.DOM
#--------------------------------------------------------------------------------
require './UserQueueTab.styl'
#--------------------------------------------------------------------------------

UserQueueTab = React.createClass {

  displayName: 'UserQueueTab'

  propTypes:
    user: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) -> {
    queue: cache('queueByUser').get(@props.user.id)
  }

  render: ->

    div {className: 'user-queue-tab'},
      'queue'

}

module.exports = UserQueueTab
