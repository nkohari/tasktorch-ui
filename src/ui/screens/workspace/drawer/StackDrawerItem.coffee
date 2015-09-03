#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
classSet        = require 'common/util/classSet'
StackType       = require 'data/enums/StackType'
PropTypes       = require 'ui/framework/PropTypes'
Navigator       = require 'ui/framework/mixins/Navigator'
StackPanelState = require 'ui/screens/workspace/panels/stack/StackPanelState'
DrawerItem      = React.createFactory(require 'ui/common/DrawerItem')
Icon            = React.createFactory(require 'ui/common/Icon')
{span}          = React.DOM
#--------------------------------------------------------------------------------

StackDrawerItem = React.createClass {

  displayName: 'StackDrawerItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'stack'
      'active' if @getScreen('workspace').isPanelVisible(@props.stack.id)
    ]

    DrawerItem {
      className: classes
      icon:      @props.stack.type.toLowerCase()
      label:     @getStackName()
      badge:     @props.stack.cards.length if @props.stack.cards.length > 0
      hotkey:    @props.hotkey
      onClick:   @toggleStack
    }

  getStackName: ->
    if @props.stack.type == StackType.Backlog
      @props.stack.name
    else
      @props.stack.type

  toggleStack: ->
    @getScreen('workspace').togglePanel(new StackPanelState(@props.stack.id))

}

module.exports = StackDrawerItem
