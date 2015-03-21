_               = require 'lodash'
React           = require 'react'
classSet        = require 'common/util/classSet'
PropTypes       = require 'ui/framework/PropTypes'
Navigator       = require 'ui/framework/mixins/Navigator'
StackPanelState = require 'ui/screens/workspace/panels/stack/StackPanelState'
Icon            = React.createFactory(require 'ui/common/Icon')
Link            = React.createFactory(require 'ui/common/Link')
{span}          = React.DOM

SpecialStackToggleButton = React.createClass {

  displayName: 'SpecialStackToggleButton'

  mixins: [Navigator]

  propTypes:
    stack:  PropTypes.Stack
    icon:   PropTypes.string
    hotkey: PropTypes.string

  render: ->

    classes = classSet [
      'button'
      'active' if @getScreen('workspace').isPanelVisible(@props.stack.id)
    ]

    Link {className: classes, hotkey: @props.hotkey, onClick: @toggleStack},
      Icon {name: "stack-#{@props.icon}"}
      span {className: 'count'}, @props.stack.cards.length

  toggleStack: ->
    @getScreen('workspace').togglePanel(new StackPanelState(@props.stack.id))

}

module.exports = SpecialStackToggleButton
