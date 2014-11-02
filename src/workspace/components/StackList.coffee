_             = require 'lodash'
React         = require 'react'
Panel         = React.createFactory(require '../../common/Panel')
StackListItem = React.createFactory(require './StackListItem')
{ul}          = React.DOM

StackList = React.createClass {

  displayName: 'StackList'

  render: ->
    stacks = _.map @props.stacks, (stack) =>
      StackListItem {key: "stack-list-#{stack.id}", stack}
    Panel {panelTitle: 'Stacks', className: 'stack-list'}, [
      ul {key: 'stack-list'}, stacks
    ]

}

module.exports = StackList
