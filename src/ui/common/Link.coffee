_          = require 'lodash'
Keymaster  = require 'keymaster'
React      = require 'react'
Router     = require 'react-router'
PropTypes  = require 'framework/PropTypes'
RouterLink = React.createFactory(Router.Link)
{a}        = React.DOM

Link = React.createClass {

  displayName: 'Link'

  mixins: [
    Router.Navigation
    Router.State
  ]

  propTypes:
    to:      PropTypes.string
    params:  PropTypes.object
    query:   PropTypes.object
    isReady: PropTypes.func

  componentDidMount: ->
    Keymaster(@props.hotkey, @onHotkeyPressed) if @props.hotkey? and @props.to?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey? and @props.to?

  onHotkeyPressed: ->
    @transitionTo(@props.to, @props.params, @props.query)

  render: ->

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    if @props.to?
      RouterLink @props, children
    else
      a @props, children

}

module.exports = Link
