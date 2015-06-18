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
    id: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'id'), {
      className:     'panel'
      'data-itemid': @props.id
    }

    div props,
      @props.children

}

module.exports = Panel
