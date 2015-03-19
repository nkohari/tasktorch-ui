_          = require 'lodash'
Keymaster  = require 'keymaster'
React      = require 'react'
Router     = require 'react-router'
PropTypes  = require 'ui/framework/PropTypes'
{a}        = React.DOM

Link = React.createClass {

  displayName: 'Link'

  mixins: [Router.Navigation]

  propTypes:
    isReady: PropTypes.func

  componentDidMount: ->
    Keymaster(@props.hotkey, @navigate) if @props.hotkey?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey?

  render: ->

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    props = _.omit(@props, 'isReady')
    a props, children

}

module.exports = Link
