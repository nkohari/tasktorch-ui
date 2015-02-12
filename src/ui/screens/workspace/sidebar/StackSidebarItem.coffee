_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
StackType = require 'framework/enums/StackType'
Url       = require 'framework/Url'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
Text      = React.createFactory(require 'ui/common/Text')

StackSidebarItem = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'StackSidebarItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Router.State]

  # Rendering ---------------------------------------------------------------------

  render: ->
    ListItem {className: 'sidebar-item'},
      Link @makeLinkProps(),
        Icon {name: "stack-#{@props.stack.type.toLowerCase()}"}
        Text {className: 'name'}, @getStackName()
        Text {className: 'count'}, @props.stack.cards.length if @props.stack.cards.length > 0

  # Utility -----------------------------------------------------------------------

  getStackName: ->
    if @props.stack.type == StackType.Backlog
      @props.stack.name
    else
      @props.stack.type

  makeLinkProps: ->
    url = new Url(this)
    url.addStack(@props.stack.id)
    return _.extend {key: 'open-link', hotkey: @props.hotkey}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = StackSidebarItem
