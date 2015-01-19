React               = require 'react'
PropTypes           = require 'common/PropTypes'
Observe             = require 'mixins/Observe'
DeleteActionRequest = require 'requests/DeleteActionRequest'
Icon                = React.createFactory(require 'common/Icon')
OverlayTrigger      = React.createFactory(require 'common/OverlayTrigger')
ConfirmOverlay      = React.createFactory(require 'common/ConfirmOverlay')
{div}               = React.DOM

ActionDeleteTrigger = React.createClass {

  displayName: 'ActionDeleteTrigger'

  propTypes:
    action: PropTypes.Action

  mixins: [Observe()]

  render: ->
    
    overlay = ConfirmOverlay {
      prompt:  'Are you sure?'
      confirm: 'Delete'
      onConfirmClicked: @deleteAction
    }

    OverlayTrigger {placement: 'top', trigger: 'click', overlay},
      Icon {key: 'delete', name: 'trash'}

  deleteAction: ->
    @execute new DeleteActionRequest(@props.action)

}

module.exports = ActionDeleteTrigger
