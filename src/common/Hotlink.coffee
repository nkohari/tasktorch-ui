_         = require 'lodash'
Keymaster = require 'keymaster'
React     = require 'react'
Router    = require 'react-router'
Link      = React.createFactory(Router.Link)

Hotlink = React.createClass {

  displayName: 'Hotlink'

  mixins: [Router.Navigation]

  componentWillMount: ->
    Keymaster(@props.hotkey, @onHotkeyPressed) if @props.hotkey?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey?

  render: ->
    Link @props, @props.children

  onHotkeyPressed: ->
    @transitionTo(@props.to, @props.params, @props.query)

}

module.exports = Hotlink
