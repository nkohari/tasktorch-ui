#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
{div}      = React.DOM
#--------------------------------------------------------------------------------
require './ActivityNote.styl'
#--------------------------------------------------------------------------------

ActivityNote = React.createClass {

  displayName: 'ActivityNote'

  propTypes:
    icon:    PropTypes.string
    isReady: PropTypes.func

  render: ->

    props = mergeProps _.omit(@props, 'icon', 'isReady'), {
      className: 'activity'
    }

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    div props,
      Icon {className: 'activity-icon', name: @props.icon}
      div {className: 'activity-body'},
        children

}

module.exports = ActivityNote
