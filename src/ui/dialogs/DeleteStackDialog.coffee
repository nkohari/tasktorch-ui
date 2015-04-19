React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
UserDeletedStackEvent = require 'events/ui/UserDeletedStackEvent'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogButtons         = React.createFactory(require 'ui/common/DialogButtons')

DeleteStackDialog = React.createClass {

  displayName: 'DeleteStackDialog'

  propTypes:
    stack:       PropTypes.Stack
    closeDialog: PropTypes.func

  mixins: [Actor]

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Delete Stack', onClick: @deleteStack, className: 'warning'}
      Button {text: 'Cancel',       onClick: @props.closeDialog}    

    Dialog {icon: 'trash', title: "Delete #{@props.stack.name}", buttons, closeDialog: @props.closeDialog},
      'Are you sure you want to delete this stack? This action cannot be undone!'

  deleteStack: ->
    @publish new UserDeletedStackEvent(@props.stack.id)
    @props.closeDialog()

}

module.exports = DeleteStackDialog
