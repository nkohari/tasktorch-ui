#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
KeyCode       = require 'ui/framework/KeyCode'
PropTypes     = require 'ui/framework/PropTypes'
Input         = React.createFactory(require 'ui/common/Input')
Icon          = React.createFactory(require 'ui/common/Icon')
KindStageList = React.createFactory(require 'ui/dialogs/kindWizard/KindStageList')
{div}         = React.DOM
#--------------------------------------------------------------------------------
require './KindStageEditor.styl'
#--------------------------------------------------------------------------------

KindStageEditor = React.createClass {

  displayName: 'KindStageEditor'

  propTypes:
    stage:       PropTypes.object
    setStages:   PropTypes.func
    addStage:    PropTypes.func
    updateStage: PropTypes.func
    removeStage: PropTypes.func

  getInitialState: ->
    {name: ''}

  render: ->

    div {className: 'kind-stage-editor'},
      div {className: 'add-stage'},
        Input {ref: 'input', icon: 'checklist', value: @state.name, placeholder: 'Add another stage', @onKeyUp, @onChange}
      KindStageList {stages: @props.stages, setStages: @props.setStages, updateStage: @props.updateStage, removeStage: @props.removeStage}

  focus: ->
    @refs.input.focus()

  onKeyUp: (event) ->
    if event.which is KeyCode.RETURN
      @addStage()

  onChange: (event) ->
    @setState {name: event.target.value}

  addStage: ->
    return unless @state.name?.length > 0
    @props.addStage({
      id:             new Date().valueOf().toString()
      name:           @state.name
      defaultActions: []
    })
    @setState {name: ''}

}

module.exports = KindStageEditor