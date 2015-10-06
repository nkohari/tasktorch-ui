#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
classSet              = require 'common/util/classSet'
UserToggledPanelEvent = require 'events/ui/UserToggledPanelEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
ViewContext           = require 'ui/framework/mixins/ViewContext'
StackPanelSpec        = require 'ui/framework/panels/StackPanelSpec'
Icon                  = React.createFactory(require 'ui/common/Icon')
Link                  = React.createFactory(require 'ui/common/Link')
{span}                = React.DOM
#--------------------------------------------------------------------------------

SpecialStackToggleButton = React.createClass {

  displayName: 'SpecialStackToggleButton'

  mixins: [Actor, ViewContext]

  propTypes:
    stack:  PropTypes.Stack
    icon:   PropTypes.string
    hotkey: PropTypes.string

  render: ->

    classes = classSet [
      'button'
      'active' if @isPanelOpen(@props.stack.id)
    ]

    Link {className: classes, hotkey: @props.hotkey, onClick: @toggleStack},
      Icon {name: @props.icon}
      span {className: 'count'}, @props.stack.cards.length

  toggleStack: ->
    @publish new UserToggledPanelEvent(new StackPanelSpec(@props.stack.id))

}

module.exports = SpecialStackToggleButton
