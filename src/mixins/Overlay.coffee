React = require 'react'

Overlay = {

  getDefaultProps: ->
    return {
      container: {getDOMNode: -> document.body}
    }

  componentDidMount: ->
    @_renderOverlay()

  componentDidUpdate: ->
    @_renderOverlay()

  componentWillUnmount: ->
    @_unmountOverlay()

  getContainerDOMNode: ->
    # If the container is a ReactElement, call getDOMNode() on it to get the DOM node.
    # Otherwise, assume that it's already a DOM node.
    if @props.container.getDOMNode?
      @props.container.getDOMNode()
    else
      @props.container

  _renderOverlay: ->
    # Create a div that can act as a layer container, and then render the overlay into it.
    unless @_layer?
      @_layer = document.createElement('div')
      @getContainerDOMNode().appendChild(@_layer)
    @_overlay = React.render(@render(), @_layer)

  _unmountOverlay: ->
    if @_layer?
      React.unmountComponentAtNode(@_layer)
      @getContainerDOMNode().removeChild(@_layer)
      @_layer = undefined
    @_overlay = undefined

}

module.exports = Overlay
