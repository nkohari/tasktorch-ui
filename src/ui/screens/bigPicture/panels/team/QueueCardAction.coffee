_            = require 'lodash'
React        = require 'react'
classSet     = require 'common/util/classSet'
ActionStatus = require 'data/enums/ActionStatus'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Avatar       = React.createFactory(require 'ui/common/Avatar')
Icon         = React.createFactory(require 'ui/common/Icon')
{div, li}    = React.DOM

QueueCardAction = React.createClass {

  displayName: 'QueueCardAction'

  propTypes:
    card:   PropTypes.Card
    stage:  PropTypes.Stage
    action: PropTypes.Action
    user:   PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.action.user) if @props.action.user?
  }

  render: ->

    classes = classSet [
      'big-picture-card-action'
      @props.action.status.toLowerCase()
    ]

    li {className: classes},
      div {className: 'stage'}, @props.stage.name
      @renderStatus()
      div {className: 'text'}, @props.action.text
      @renderOwner()

  renderOwner: ->

    if @props.action.user == @props.card.user
      return null

    if @state.user?
      owner = Avatar {user: @state.user}
    else
      owner = Icon {name: 'user'}

    div {className: 'owner'}, owner

  renderStatus: ->
    
    if @props.action.status == ActionStatus.Warning
      div {className: 'status'}, Icon {name: @props.action.status.toLowerCase()}
    else
      null

}

module.exports = QueueCardAction
