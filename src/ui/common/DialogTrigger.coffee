#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
{a}                   = React.DOM
#--------------------------------------------------------------------------------

DialogTrigger = React.createClass {

  displayName: 'DialogTrigger'

  propTypes:
    name:    PropTypes.string
    onClick: PropTypes.func

  mixins: [Actor]

  render: ->

    a {className: @props.className, @onClick}, @props.children

  onClick: (event) ->
    @props.onClick(event) if @props.onClick?
    @publish new UserOpenedDialogEvent(@props.name, _.omit(@props, 'name'))

}

module.exports = DialogTrigger
