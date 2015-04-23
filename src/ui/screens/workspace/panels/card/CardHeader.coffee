_                = require 'lodash'
React            = require 'react/addons'
classSet         = require 'common/util/classSet'
CardCommand      = require 'data/enums/CardCommand'
PropTypes        = require 'ui/framework/PropTypes'
Avatar           = React.createFactory(require 'ui/common/Avatar')
Frame            = React.createFactory(require 'ui/common/Frame')
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
CardOwner        = React.createFactory(require 'ui/common/CardOwner')
CardTitle        = React.createFactory(require 'ui/screens/workspace/panels/card/CardTitle')
CardWidgets      = React.createFactory(require 'ui/screens/workspace/panels/card/CardWidgets')
{div}            = React.DOM

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
      @props.kind.color
    ]

    Frame {@isReady, className: classes},
      CardOwner {card: @props.card}
      div {className: 'card-info'},
        CardTitle   {card: @props.card}
        CardWidgets {card: @props.card, kind: @props.kind, stack: @props.stack}
      div {className: 'controls'},
        CardFollowToggle {card: @props.card}
}

module.exports = CardHeader
