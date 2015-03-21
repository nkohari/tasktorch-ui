_                   = require 'lodash'
React               = require 'react'
mergeProps          = require 'common/util/mergeProps'
PropTypes           = require 'ui/framework/PropTypes'
StackPanelState     = require 'ui/screens/workspace/panels/stack/StackPanelState'
CardPanelState      = require 'ui/screens/workspace/panels/card/CardPanelState'
FollowingPanelState = require 'ui/screens/workspace/panels/following/FollowingPanelState'
StackPanel          = React.createFactory(require 'ui/screens/workspace/panels/stack/StackPanel')
CardPanel           = React.createFactory(require 'ui/screens/workspace/panels/card/CardPanel')
FollowingPanel      = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingPanel')

WorkspacePanel = React.createClass {

  displayName: 'WorkspacePanel'

  propTypes:
    type: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      'data-itemid': @props.id
    }

    switch @props.type
      when StackPanelState.type     then StackPanel(props)
      when CardPanelState.type      then CardPanel(props)
      when FollowingPanelState.type then FollowingPanel(props)

}

module.exports = WorkspacePanel
