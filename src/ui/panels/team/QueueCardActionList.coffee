_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
QueueCardAction = React.createFactory(require 'ui/panels/team/QueueCardAction')
{div, ul}       = React.DOM

QueueCardActionList = React.createClass {

  displayName: 'QueueCardActionList'

  propTypes:
    actions: PropTypes.arrayOf(PropTypes.Action)
    card:    PropTypes.Card
    kind:    PropTypes.Kind
    stage:   PropTypes.Stage

  render: ->

    items = _.map @props.actions, (action) =>
      QueueCardAction {key: action.id, stage: @props.stage, action}

    ul {className: 'queue-card-action-list'}, items

}

module.exports = QueueCardActionList
