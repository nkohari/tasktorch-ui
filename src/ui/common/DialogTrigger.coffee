#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
classSet              = require 'common/util/classSet'
mergeProps            = require 'common/util/mergeProps'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
{a}                   = React.DOM
#--------------------------------------------------------------------------------

DialogTrigger = React.createClass {

  displayName: 'DialogTrigger'

  propTypes:
    name:        PropTypes.string
    onActivated: PropTypes.func

  mixins: [Actor]

  getInitialState: ->
    {hover: false}

  render: ->

    props = mergeProps _.omit(@props, 'name', 'onActivated'), {
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
    @props.onActivated(event) if @props.onActivated?
    @publish new UserOpenedDialogEvent(@props.name, _.omit(@props, 'name', 'onActivated'))

}

module.exports = DialogTrigger
