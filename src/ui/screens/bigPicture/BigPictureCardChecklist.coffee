#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
classSet             = require 'common/util/classSet'
ActionStatus         = require 'data/enums/ActionStatus'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
BigPictureCardAction = React.createFactory(require 'ui/screens/bigPicture/BigPictureCardAction')
{div, ul}            = React.DOM
#--------------------------------------------------------------------------------

BigPictureCardChecklist = React.createClass {

  displayName: 'BigPictureCardChecklist'

  propTypes:
    card:      PropTypes.Card
    kind:      PropTypes.Kind
    checklist: PropTypes.Checklist
    stage:     PropTypes.Stage
    actions:   PropTypes.arrayOf(PropTypes.Action)

  render: ->

    items = _.map @props.actions, (action) =>
      BigPictureCardAction {key: action.id, card: @props.card, stage: @props.stage, action}

    classes = classSet [
      'big-picture-card-action-list'
      'empty' if items?.length == 0
    ]

    ul {className: classes}, items

}

module.exports = BigPictureCardChecklist
