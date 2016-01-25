#--------------------------------------------------------------------------------
_                            = require 'lodash'
React                        = require 'react'
UserAddedCardToGoalEvent     = require 'events/ui/UserAddedCardToGoalEvent'
UserRemovedCardFromGoalEvent = require 'events/ui/UserRemovedCardFromGoalEvent'
PropTypes                    = require 'ui/framework/PropTypes'
Actor                        = require 'ui/framework/mixins/Actor'
CachedState                  = require 'ui/framework/mixins/CachedState'
DialogTrigger                = React.createFactory(require 'ui/common/DialogTrigger')
Overlay                      = React.createFactory(require 'ui/common/Overlay')
{div, ul, li}                = React.DOM
#--------------------------------------------------------------------------------

CardEffortOverlay = React.createClass {

  displayName: 'CardEffortOverlay'

  propTypes:
    card:        PropTypes.Card
    hideOverlay: PropTypes.func

  mixins: [Actor]

  render: ->

    Overlay {className: 'card-effort-overlay', arrow: true, hideOverlay: @props.hideOverlay},
      'Effort'

}

module.exports = CardEffortOverlay
