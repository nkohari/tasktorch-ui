_               = require 'lodash'
React           = require 'react'
classSet        = require 'common/util/classSet'
StackType       = require 'data/enums/StackType'
PropTypes       = require 'ui/framework/PropTypes'
Navigator       = require 'ui/framework/mixins/Navigator'
StackPanelState = require 'ui/screens/workspace/panels/stack/StackPanelState'
Icon            = React.createFactory(require 'ui/common/Icon')
Link            = React.createFactory(require 'ui/common/Link')
{span}          = React.DOM

StackDrawerItem = React.createClass {

  displayName: 'StackDrawerItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'drawer-item'
      'active' if @getScreen('workspace').isPanelVisible(@props.stack.id)
    ]

    Link {className: classes, hotkey: @props.hotkey, onClick: @toggleStack},
      Icon {name: @props.stack.type.toLowerCase()}
      span {className: 'name'}, @getStackName()
      span {className: 'count'}, @props.stack.cards.length if @props.stack.cards.length > 0

  getStackName: ->
    if @props.stack.type == StackType.Backlog
      @props.stack.name
    else
      @props.stack.type

  toggleStack: ->
    @getScreen('workspace').togglePanel(new StackPanelState(@props.stack.id))

}

module.exports = StackDrawerItem
