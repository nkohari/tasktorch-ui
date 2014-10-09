_                  = require 'lodash'
React              = require 'react/addons'
Router             = require 'react-router'
Icon               = require '../common/Icon'
WorkspaceViewState = require './WorkspaceViewState'
{li, span}         = React.DOM
{classSet}         = React.addons
{Link}             = Router

StackListItem = React.createClass {

  mixins: [Router.ActiveState],

  getDefaultState: ->
    {stack: undefined}

  componentWillReceiveProps: (newProps) ->
    @setState {stack: newProps.stack}

  componentWillMount: ->
    @setState {stack: @props.stack}

  render: ->
    li {className: 'stack-list-item'}, [
      Link @makeLinkProps(), [
        Icon {name: "stack-#{@state.stack.kind}"}
        span {className: 'stack-name'}, [@state.stack.name]
        span {className: 'stack-card-count'}, [@state.stack.cards.length]
      ]
    ]

  makeLinkProps: ->
    viewState = new WorkspaceViewState(this)
    viewState.addStack(@state.stack.id)
    return viewState.makeLinkProps()

}

module.exports = StackListItem
