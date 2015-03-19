_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
StackType = require 'data/enums/StackType'
PropTypes = require 'ui/framework/PropTypes'
Navigator = require 'ui/framework/mixins/Navigator'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
Text      = React.createFactory(require 'ui/common/Text')

StackSidebarItem = React.createClass {

  displayName: 'StackSidebarItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'active' if @getScreen('workspace').isPanelVisible(@props.stack.id)
    ]

    ListItem {className: 'sidebar-item'},
      Link {className: classes, hotkey: @props.hotkey, onClick: @toggleStack},
        Icon {name: "stack-#{@props.stack.type.toLowerCase()}"}
        Text {className: 'name'}, @getStackName()
        Text {className: 'count'}, @props.stack.cards.length if @props.stack.cards.length > 0

  getStackName: ->
    if @props.stack.type == StackType.Backlog
      @props.stack.name
    else
      @props.stack.type

  toggleStack: ->
    @getScreen('workspace').togglePanel {
      type: 'stack'
      id:   @props.stack.id
    }

}

module.exports = StackSidebarItem
