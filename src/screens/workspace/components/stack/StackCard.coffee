React        = require 'react/addons'
Router       = require 'react-router'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../../WorkspaceUrl'
{div}        = React.DOM
{classSet}   = React.addons

StackCard = React.createClass {

  displayName: 'StackCard'

  mixins: [ActiveUrl(WorkspaceUrl), Router.Navigation]

  getInitialState: ->
    {dragging: false, hovering: false}

  render: ->

    classes = 
      'stack-card': true
      dragging:     @state.dragging
      hovering:     @state.hovering
      active:       @getActiveUrl().isCardActive(@props.card.id)

    div {
      className:      classSet(classes)
      draggable:      true
      'aria-grabbed': @state.dragging
      onClick:        @handleClick
    }, @props.children

  handleClick: ->
    url = @getActiveUrl()
    url.addCard(@props.card.id)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

}

module.exports = StackCard
