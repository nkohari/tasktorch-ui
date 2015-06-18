#--------------------------------------------------------------------------------
React                  = require 'react'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
UserDeletedActionEvent = require 'events/ui/UserDeletedActionEvent'
Button                 = React.createFactory(require 'ui/common/Button')
Overlay                = React.createFactory(require 'ui/common/Overlay')
{div}                  = React.DOM
#--------------------------------------------------------------------------------

DeleteActionOverlay = React.createClass {

  displayName: 'DeleteActionOverlay'

  propTypes:
    action:      PropTypes.Action
    hideOverlay: PropTypes.func

  mixins: [Actor]

  render: ->
    
    Overlay {arrow: true, position: 'bottom right'},
      "Are you sure you want to delete this action?"
      div {className: 'buttons'},
        Button {className: 'small', text: 'Delete', onClick: @onDeleteClicked}
        Button {className: 'small', text: 'Cancel', onClick: @onCancelClicked}

  onDeleteClicked: ->
    @publish new UserDeletedActionEvent(@props.action.id)
    @props.hideOverlay()

  onCancelClicked: ->
    @props.hideOverlay()

}

module.exports = DeleteActionOverlay
