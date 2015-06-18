#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
GoalPanelState = require 'ui/screens/bigPicture/panels/goal/GoalPanelState'
KindPanelState = require 'ui/screens/bigPicture/panels/kind/KindPanelState'
TeamPanelState = require 'ui/screens/bigPicture/panels/team/TeamPanelState'
GoalPanel      = React.createFactory(require 'ui/screens/bigPicture/panels/goal/GoalPanel')
KindPanel      = React.createFactory(require 'ui/screens/bigPicture/panels/kind/KindPanel')
TeamPanel      = React.createFactory(require 'ui/screens/bigPicture/panels/team/TeamPanel')
#--------------------------------------------------------------------------------
require './BigPicturePanel.styl'
#--------------------------------------------------------------------------------

BigPicturePanel = React.createClass {

  displayName: 'BigPicturePanel'

  propTypes:
    type: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      'data-itemid': @props.id
    }

    switch @props.type
      when GoalPanelState.type then GoalPanel(props)
      when KindPanelState.type then KindPanel(props)
      when TeamPanelState.type then TeamPanel(props)

}

module.exports = BigPicturePanel
