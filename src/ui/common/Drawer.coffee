#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{div}      = React.DOM
#--------------------------------------------------------------------------------
require './Drawer.styl'
#--------------------------------------------------------------------------------

Drawer = React.createClass {

  displayName: 'Drawer'

  render: ->

    props = mergeProps @props, {
      className: 'drawer'
    }

    div props, @props.children

}

module.exports = Drawer
