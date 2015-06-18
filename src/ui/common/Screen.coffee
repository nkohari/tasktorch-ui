#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{div}      = React.DOM
#--------------------------------------------------------------------------------
require './Screen.styl'
#--------------------------------------------------------------------------------

Screen = React.createClass {

  displayName: 'Screen'

  propTypes:
    isReady: PropTypes.func

  render: ->

    props = mergeProps _.omit(@props, 'isReady'), {
      className: 'screen'
    }

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    div props, children

}

module.exports = Screen
