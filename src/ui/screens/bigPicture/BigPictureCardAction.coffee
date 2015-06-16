_            = require 'lodash'
React        = require 'react'
classSet     = require 'common/util/classSet'
ActionStatus = require 'data/enums/ActionStatus'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Icon         = React.createFactory(require 'ui/common/Icon')
{div, li}    = React.DOM

BigPictureCardAction = React.createClass {

  displayName: 'BigPictureCardAction'

  propTypes:
    card:   PropTypes.Card
    stage:  PropTypes.Stage
    action: PropTypes.Action

  render: ->

    classes = classSet [
      'big-picture-card-action'
      @props.action.status.toLowerCase()
    ]

    li {className: classes},
      div {className: 'status'}, Icon {name: @props.action.status.toLowerCase()}
      div {className: 'text'},   @props.action.text
      div {className: 'stage'},  @props.stage.name

}

module.exports = BigPictureCardAction
