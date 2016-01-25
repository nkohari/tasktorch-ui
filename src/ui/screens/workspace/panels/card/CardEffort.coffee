#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
classSet          = require 'common/util/classSet'
PropTypes         = require 'ui/framework/PropTypes'
Icon              = React.createFactory(require 'ui/common/Icon')
OverlayTrigger    = React.createFactory(require 'ui/common/OverlayTrigger')
CardEffortOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/CardEffortOverlay')
{span}            = React.DOM
#--------------------------------------------------------------------------------

CardEffort = React.createClass {

  displayName: 'CardEffort'

  propTypes:
    card: PropTypes.Card

  render: ->

    {effort} = @props.card

    if effort?
      percent = Math.floor(100 * (effort.remaining / effort.total))
      content = "#{effort.remaining} of #{effort.total} (#{percent}%)"
    else
      content = 'Add estimate...'

    overlay = CardEffortOverlay {card: @props.card}

    classes = classSet [
      'effort'
      'card-widget'
      'empty' unless effort?
    ]

    OverlayTrigger {className: classes, overlay},
      span {},
        Icon {name: 'effort'}
        content

}

module.exports = CardEffort
