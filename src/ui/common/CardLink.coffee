#--------------------------------------------------------------------------------
React                = require 'react'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CardPanelSpec        = require 'ui/framework/panels/CardPanelSpec'
Icon                 = React.createFactory(require 'ui/common/Icon')
{a}                  = React.DOM
#--------------------------------------------------------------------------------

CardLink = React.createClass {

  displayName: 'CardLink'

  propTypes:
    card:    PropTypes.Card
    onClick: PropTypes.func

  mixins: [Actor]

  render: ->

    a {className: 'trigger', onClick: @props.onClick ? @showCard},
      Icon {name: 'link'}

  showCard: ->
    @publish new UserOpenedPanelEvent(new CardPanelSpec(@props.card.id))

}

module.exports = CardLink
