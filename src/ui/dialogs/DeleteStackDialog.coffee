React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
UserDeletedStackEvent = require 'events/ui/UserDeletedStackEvent'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogButtons         = React.createFactory(require 'ui/common/DialogButtons')
{div}                 = React.DOM

DeleteStackDialog = React.createClass {

  displayName: 'DeleteStackDialog'

  propTypes:
    stack:        PropTypes.Stack
    closeDialog: PropTypes.func

  mixins: [Actor]

  render: ->

    Dialog {icon: 'trash', title: "Delete #{@props.stack.name}", @closeDialog},
      'Are you sure you want to delete this stack? This action cannot be undone!'
      DialogButtons {},
        Button {text: 'Delete Stack', className: 'warning', onClick: @deleteStack}
        Button {text: 'Cancel', onClick: @props.closeDialog}    

  deleteStack: ->
    @publish new UserDeletedStackEvent(@props.stack.id)
    @props.closeDialog()

}

module.exports = DeleteStackDialog
