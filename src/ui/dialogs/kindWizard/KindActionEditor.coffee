#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
Icon                = React.createFactory(require 'ui/common/Icon')
KindActionList      = React.createFactory(require 'ui/dialogs/kindWizard/KindActionList')
KindActionAddForm   = React.createFactory(require 'ui/dialogs/kindWizard/KindActionAddForm')
{div, li, ul, span} = React.DOM
#--------------------------------------------------------------------------------
require './KindActionEditor.styl'
#--------------------------------------------------------------------------------

KindActionEditor = React.createClass {

  displayName: 'KindActionEditor'

  propTypes:
    stages:       PropTypes.arrayOf(PropTypes.object)
    setActions:   PropTypes.func
    addAction:    PropTypes.func
    updateAction: PropTypes.func
    removeAction: PropTypes.func

  render: ->

    items = _.map @props.stages, (stage) =>
      li {key: stage.id, className: 'stage'},
        div {className: 'header'},
          Icon {name: 'checklist'}
          span {className: 'stage-name'}, stage.name
        KindActionList {stage, setActions: @props.setActions, updateAction: @props.updateAction, removeAction: @props.removeAction}
        KindActionAddForm {stage, addAction: @props.addAction}

    ul {className: 'kind-action-editor'}, items

}

module.exports = KindActionEditor