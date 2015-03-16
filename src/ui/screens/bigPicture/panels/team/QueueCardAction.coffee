_           = require 'lodash'
React       = require 'react'
classSet    = require 'common/util/classSet'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Avatar      = React.createFactory(require 'ui/common/Avatar')
ListItem    = React.createFactory(require 'ui/common/ListItem')
Icon        = React.createFactory(require 'ui/common/Icon')
{div}       = React.DOM

QueueCardAction = React.createClass {

  displayName: 'QueueCardAction'

  propTypes:
    stage:  PropTypes.Stage
    action: PropTypes.Action

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.action.user) if @props.action.user?
  }

  isReady: ->
    (@state.user? or not @props.action.user?)

  render: ->

    if @state.user?
      owner = Avatar {user: @state.user}
    else
      owner = Icon {name: 'user'}

    classes = classSet [
      'queue-card-action'
      @props.action.status.toLowerCase()
    ]

    ListItem {@isReady, className: classes},
      div {className: 'status'}, Icon {name: "action-#{@props.action.status.toLowerCase()}"}
      div {className: 'owner'},  owner
      div {className: 'text'},   @props.action.text
      div {className: 'stage'},  @props.stage.name

}

module.exports = QueueCardAction
