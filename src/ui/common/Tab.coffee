#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{div}      = React.DOM
#--------------------------------------------------------------------------------

Tab = React.createClass {

  displayName: 'Tab'

  propTypes:
    title: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'title'), {
      className: 'tab'
    }

    div props, @props.children

}

module.exports = Tab
