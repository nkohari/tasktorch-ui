#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
classSet              = require 'common/util/classSet'
StackType             = require 'data/enums/StackType'
UserToggledPanelEvent = require 'events/ui/UserToggledPanelEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
ViewContext           = require 'ui/framework/mixins/ViewContext'
StackPanelSpec        = require 'ui/framework/panels/StackPanelSpec'
DrawerItem            = React.createFactory(require 'ui/common/DrawerItem')
Icon                  = React.createFactory(require 'ui/common/Icon')
{span}                = React.DOM
#--------------------------------------------------------------------------------

StackDrawerItem = React.createClass {

  displayName: 'StackDrawerItem'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Actor, ViewContext]

  render: ->

    classes = classSet [
      'stack'
      'active' if @isPanelOpen(@props.stack.id)
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
    switch @props.stack.type
      when StackType.Inbox then 'Inbox'
      when StackType.Queue then 'Priorities'
      else @props.stack.name

  toggleStack: ->
    @publish new UserToggledPanelEvent(new StackPanelSpec(@props.stack.id))

}

module.exports = StackDrawerItem
