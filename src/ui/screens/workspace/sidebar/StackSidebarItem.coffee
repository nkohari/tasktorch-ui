_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
StackType = require 'data/enums/StackType'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
UrlAware  = require 'ui/framework/mixins/UrlAware'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
Text      = React.createFactory(require 'ui/common/Text')

StackSidebarItem = React.createClass {

  displayName: 'StackSidebarItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [UrlAware]

  render: ->

    classes = classSet [
      'active' if @getCurrentUrl().isPanelActive(PanelKey.forStack(@props.stack.id))
    ]

    ListItem {className: 'sidebar-item'},
      Link {className: classes, hotkey: @props.hotkey, @getLinkUrl},
        Icon {name: "stack-#{@props.stack.type.toLowerCase()}"}
        Text {className: 'name'}, @getStackName()
        Text {className: 'count'}, @props.stack.cards.length if @props.stack.cards.length > 0

  getStackName: ->
    if @props.stack.type == StackType.Backlog
      @props.stack.name
    else
      @props.stack.type

  getLinkUrl: (currentUrl) ->
    currentUrl.togglePanel(PanelKey.forStack(@props.stack.id))

}

module.exports = StackSidebarItem
