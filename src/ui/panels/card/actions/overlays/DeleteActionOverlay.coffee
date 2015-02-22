React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
DeleteActionRequest = require 'requests/DeleteActionRequest'
Button              = React.createFactory(require 'ui/common/Button')
Overlay             = React.createFactory(require 'ui/common/Overlay')
{div}               = React.DOM

DeleteActionOverlay = React.createClass {

  displayName: 'DeleteActionOverlay'

  propTypes:
    action: PropTypes.Action
    hide:   PropTypes.func

  mixins: [Observe()]

  render: ->
    
    Overlay {arrow: true, position: 'right'},
      "Are you sure you want to delete this action?"
      div {className: 'buttons'},
        Button {className: 'small', text: 'Delete', onClick: @onDeleteClicked}
        Button {className: 'small', text: 'Cancel', onClick: @onCancelClicked}

  onDeleteClicked: ->
    @execute new DeleteActionRequest(@props.action)
    @props.hide()

  onCancelClicked: ->
    @props.hide()

}

module.exports = DeleteActionOverlay
