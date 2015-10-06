#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
classSet    = require 'common/util/classSet'
PropTypes   = require 'ui/framework/PropTypes'
Avatar      = React.createFactory(require 'ui/common/Avatar')
CardOwner   = React.createFactory(require 'ui/common/CardOwner')
CardWidgets = React.createFactory(require 'ui/screens/workspace/panels/card/CardWidgets')
CardTitle   = React.createFactory(require 'ui/screens/workspace/panels/card/CardTitle')
{div}       = React.DOM
#--------------------------------------------------------------------------------
require './CardHeader.styl'
#--------------------------------------------------------------------------------

CardHeader = React.createClass {

  displayName: 'CardHeader'

  propTypes:
    card:    PropTypes.Card
    kind:    PropTypes.Kind
    stack:   PropTypes.Stack
    panelid: PropTypes.string

  render: ->

    classes = classSet [
      'card-header'
      @props.kind.color.toLowerCase() if @props.kind?
    ]

    div {className: classes},
      CardOwner {card: @props.card}
      div {className: 'card-info'},
        CardWidgets {card: @props.card, kind: @props.kind, stack: @props.stack}
        CardTitle   {card: @props.card}

}

module.exports = CardHeader
