#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{div}      = React.DOM
#--------------------------------------------------------------------------------
require './Panel.styl'
#--------------------------------------------------------------------------------

Panel = React.createClass {

  displayName: 'Panel'

  propTypes:
    id:      PropTypes.string
    isReady: PropTypes.func

  render: ->

    props = mergeProps _.omit(@props, 'id'), {
      className:     'panel'
      'data-itemid': @props.id
    }

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    div props, children

}

module.exports = Panel
