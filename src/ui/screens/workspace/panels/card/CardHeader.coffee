#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Pure             = require 'ui/framework/mixins/Pure'
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
Icon             = React.createFactory(require 'ui/common/Icon')
OverlayTrigger   = React.createFactory(require 'ui/common/OverlayTrigger')
PanelHeader      = React.createFactory(require 'ui/common/PanelHeader')
{div}            = React.DOM
#--------------------------------------------------------------------------------
require './CardHeader.styl'
#--------------------------------------------------------------------------------

CardHeader = React.createClass {

  displayName: 'CardHeader'

  propTypes:
    card:    PropTypes.Card
    kind:    PropTypes.Kind
    panelid: PropTypes.string

  mixins: [Pure]

  render: ->

    controls = CardFollowToggle {card: @props.card}
    icon = Icon {name: 'card', color: @props.kind?.color}

    PanelHeader {className: 'card-header', panelid: @props.panelid, icon, controls},
      "#{@props.kind?.name} #{@props.card?.number}"

}

module.exports = CardHeader
