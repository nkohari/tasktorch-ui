#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
EditableInput = React.createFactory(require 'ui/common/EditableInput')
Icon          = React.createFactory(require 'ui/common/Icon')
{a, div, li}  = React.DOM
#--------------------------------------------------------------------------------

KindStageListItem = React.createClass {

  displayName: 'KindStageListItem'

  propTypes:
    stage:       PropTypes.object
    updateStage: PropTypes.func
    removeStage: PropTypes.func

  render: ->

    li {className: 'kind-stage-list-item', 'data-itemid': @props.stage.id},
      div {className: 'stage-content'},
        Icon {name: 'checklist'}
        EditableInput {
          className: 'stage-name'
          value: @props.stage.name
          save: @onNameChanged
        }
        a {className: 'trigger', onClick: @onDeleteClicked},
          Icon {name: 'remove'}

  onNameChanged: (name) ->
    @props.updateStage(@props.stage.id, name)

  onDeleteClicked: ->
    @props.removeStage(@props.stage.id)

}

module.exports = KindStageListItem