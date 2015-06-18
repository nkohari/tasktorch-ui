#--------------------------------------------------------------------------------
React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
UserDeletedStackEvent = require 'events/ui/UserDeletedStackEvent'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogButtons         = React.createFactory(require 'ui/common/DialogButtons')
Prompt                = React.createFactory(require 'ui/common/Prompt')
#--------------------------------------------------------------------------------

DeleteStackDialog = React.createClass {

  displayName: 'DeleteStackDialog'

  propTypes:
    stackid:     PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.stackid)
  }

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Delete Stack', onClick: @deleteStack, className: 'warning'}
      Button {text: 'Cancel',       onClick: @props.closeDialog}

    Dialog {icon: 'trash', title: "Delete #{@state.stack?.name}", buttons, closeDialog: @props.closeDialog},
      Prompt {hint: 'delete-stack'},
        'Are you sure you want to delete this stack?'

  deleteStack: ->
    @publish new UserDeletedStackEvent(@props.stackid)
    @props.closeDialog()

}

module.exports = DeleteStackDialog
