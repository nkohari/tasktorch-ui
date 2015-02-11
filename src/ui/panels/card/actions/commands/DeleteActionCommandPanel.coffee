React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
DeleteActionRequest = require 'requests/DeleteActionRequest'
Button              = React.createFactory(require 'ui/common/Button')
{div}               = React.DOM

DeleteActionCommandPanel = React.createClass {

  displayName: 'DeleteActionCommandPanel'

  propTypes:
    action:      PropTypes.Action
    hideCommand: PropTypes.func

  mixins: [Observe()]

  render: ->
    div {className: 'action-command'}, [
      div {className: 'buttons'}, [
        Button {key: 'confirm', className: 'small', text: 'Delete', onClick: @onDeleteClicked}
        Button {key: 'cancel',  className: 'small', text: 'Cancel', onClick: @onCancelClicked}
      ]
    ]

  onDeleteClicked: ->
    @execute new DeleteActionRequest(@props.action)
    @props.hideCommand()

  onCancelClicked: ->
    @props.hideCommand()

}

module.exports = DeleteActionCommandPanel
