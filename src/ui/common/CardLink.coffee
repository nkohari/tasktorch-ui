React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
CardPanelState = require 'ui/screens/workspace/panels/card/CardPanelState'
Icon           = React.createFactory(require 'ui/common/Icon')
{a}            = React.DOM

CardLink = React.createClass {

  displayName: 'CardLink'

  propTypes:
    card:    PropTypes.Card
    onClick: PropTypes.func

  mixins: [Navigator]

  render: ->

    a {className: 'trigger', onClick: @props.onClick ? @showCard},
      Icon {name: 'link'}

  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = CardLink
