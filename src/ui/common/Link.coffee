_          = require 'lodash'
Keymaster  = require 'keymaster'
React      = require 'react'
Router     = require 'react-router'
PropTypes  = require 'ui/framework/PropTypes'
mergeProps = require 'common/util/mergeProps'
{a}        = React.DOM

Link = React.createClass {

  displayName: 'Link'

  mixins: [Router.Navigation]

  propTypes:
    getLinkUrl: PropTypes.func
    isReady:    PropTypes.func

  componentDidMount: ->
    Keymaster(@props.hotkey, @navigate) if @props.hotkey?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey?

  render: ->

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    props = mergeProps _.omit(@props, 'getLinkUrl', 'isReady'), {
      onClick: @navigate
    }

    a props, children

  navigate: ->
    url   = @props.getLinkUrl(Environment.currentUrl)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

}

module.exports = Link
