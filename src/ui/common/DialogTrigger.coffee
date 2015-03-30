_                     = require 'lodash'
React                 = require 'react'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
{a}                   = React.DOM

DialogTrigger = React.createClass {

  displayName: 'DialogTrigger'

  propTypes:
    name: PropTypes.string

  mixins: [Actor]

  render: ->
    a {@onClick}, @props.children

  onClick: ->
    @publish new UserOpenedDialogEvent(@props.name, _.omit(@props, 'name'))

}

module.exports = DialogTrigger
