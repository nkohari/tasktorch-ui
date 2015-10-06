#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
Keymaster             = require 'keymaster'
UserClosedDialogEvent = require 'events/ui/UserClosedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
CSSTransitionGroup    = React.createFactory(React.addons.CSSTransitionGroup)
{cloneWithProps}      = React.addons
#--------------------------------------------------------------------------------

DialogContainer = React.createClass {

  displayName: 'DialogContainer'

  propTypes:
    name: PropTypes.string

  mixins: [Actor, CachedState]

  componentDidMount: ->
    Keymaster('esc', @closeDialog)

  componentWillUnmount: ->
    Keymaster.unbind('esc', @closeDialog)

  getCachedState: (cache) -> {
    dialogProps: cache('dialogs').get(@props.name)
  }

  render: ->
    
    if @state.dialogProps?
      props   = _.extend {@closeDialog}, @state.dialogProps
      content = cloneWithProps React.Children.only(@props.children), props
    else
      content = []

    CSSTransitionGroup {component: 'div', className: 'dialog-placeholder', transitionName: 'fade'},
      content

  closeDialog: ->
    @publish new UserClosedDialogEvent(@props.name) if @state.dialogProps?

}

module.exports = DialogContainer
