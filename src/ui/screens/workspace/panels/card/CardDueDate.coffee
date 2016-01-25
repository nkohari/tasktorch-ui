#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
classSet           = require 'common/util/classSet'
PropTypes          = require 'ui/framework/PropTypes'
Icon               = React.createFactory(require 'ui/common/Icon')
Time               = React.createFactory(require 'ui/common/Time')
OverlayTrigger     = React.createFactory(require 'ui/common/OverlayTrigger')
CardDueDateOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/CardDueDateOverlay')
{span}             = React.DOM
#--------------------------------------------------------------------------------

CardDueDate = React.createClass {

  displayName: 'CardDueDate'

  propTypes:
    card: PropTypes.Card

  render: ->

    if @props.card.due?
      content = Time {time: @props.card.due, format: 'D MMM YYYY?'}
    else
      content = 'Add due date'

    overlay = CardDueDateOverlay {card: @props.card}

    classes = classSet [
      'due'
      'card-widget'
      'empty' unless @props.card.due?
    ]

    OverlayTrigger {className: classes, overlay},
      span {},
        Icon {name: 'date'}
        content

}

module.exports = CardDueDate
