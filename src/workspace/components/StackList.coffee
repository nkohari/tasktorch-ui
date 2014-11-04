_             = require 'lodash'
React         = require 'react'
StackListItem = React.createFactory(require './StackListItem')
{ul}          = React.DOM

StackList = React.createClass {

  displayName: 'StackList'

  render: ->
    stacks = _.map @props.stacks, (stack) =>
      StackListItem {key: "stack-list-#{stack.id}", stack}
    ul {key: 'stack-list', className: 'stack-list'}, stacks

}

module.exports = StackList
