_              = require 'lodash'
React          = require 'react'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
StackPanel     = React.createFactory(require 'ui/screens/workspace/panels/stack/StackPanel')
CardPanel      = React.createFactory(require 'ui/screens/workspace/panels/card/CardPanel')
FollowingPanel = React.createFactory(require 'ui/screens/workspace/panels/following/FollowingPanel')

WorkspacePanel = React.createClass {

  displayName: 'WorkspacePanel'

  propTypes:
    type: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      'data-itemid': @props.id
    }

    switch @props.type
      when 'stack'     then StackPanel(props)
      when 'card'      then CardPanel(props)
      when 'following' then FollowingPanel(props)

}

module.exports = WorkspacePanel
