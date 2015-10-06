#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
EditableInput = React.createFactory(require 'ui/common/EditableInput')
Icon          = React.createFactory(require 'ui/common/Icon')
{a, div, li}  = React.DOM
#--------------------------------------------------------------------------------

KindActionListItem = React.createClass {

  displayName: 'KindActionListItem'

  propTypes:
    action:       PropTypes.object
    stage:        PropTypes.object
    updateAction: PropTypes.func
    removeAction: PropTypes.func

  render: ->

    li {className: 'kind-action-list-item', 'data-id': @props.action.id},
      div {className: 'action-content'},
        EditableInput {
          className: 'action-text'
          value: @props.action.text
          save: @onTextChanged
        }
        a {className: 'trigger', onClick: @onDeleteClicked},
          Icon {name: 'remove'}

  onTextChanged: (text) ->
    @props.updateAction(@props.stage.id, @props.action.id, text)

  onDeleteClicked: ->
    @props.removeAction(@props.stage.id, @props.action.id)

}

module.exports = KindActionListItem