#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{a}        = React.DOM
#--------------------------------------------------------------------------------

MenuOption = React.createClass {

  displayName: 'MenuOption'

  propTypes:
    name:        PropTypes.string
    onActivated: PropTypes.func

  getInitialState: ->
    {hover: false}

  render: ->

    props = mergeProps _.omit(@props, 'onActivated'), {
      className: classSet [
        'hover' if @state.hover
      ]
      @onMouseOver
      @onMouseOut
      @onMouseUp
    }

    a props, @props.children

  onMouseOver: ->
    @setState {hover: true}

  onMouseOut: ->
    @setState {hover: false}

  onMouseUp: (event) ->
    @props.onActivated(event)

}

module.exports = MenuOption
