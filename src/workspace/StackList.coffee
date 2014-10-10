_             = require 'lodash'
React         = require 'react'
Panel         = require '../common/Panel'
StackListItem = require './StackListItem'
{ul}          = React.DOM

StackList = React.createClass {

  render: ->
    stacks = _.map @props.stacks, (stack) =>
      StackListItem {key: "stack-list-#{stack.id}", stack}
    Panel {panelTitle: 'Stacks', className: 'stack-list'}, [
      ul {}, stacks
    ]

}

module.exports = StackList
