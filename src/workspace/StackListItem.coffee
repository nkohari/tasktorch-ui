_          = require 'lodash'
React      = require 'react/addons'
Router     = require 'react-router'
Icon       = require '../common/Icon'
{li, span} = React.DOM
{classSet} = React.addons
{Link}     = Router

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
      Link {to: 'workspace', params: @getActiveParams(), query: @buildQuery()}, [
        Icon {name: "stack-#{@state.stack.kind}"}
        span {className: 'stack-name'}, [@state.stack.name]
        span {className: 'stack-card-count'}, [@state.stack.cards.length]
      ]
    ]

  buildQuery: ->
    query = _.clone @getActiveQuery()
    stacks = if query.stacks? then query.stacks.split(',') else []
    stacks.push(@state.stack.id) unless _.contains(stacks, @state.stack.id)
    query.stacks = stacks.join(',')
    return query

}

module.exports = StackListItem
