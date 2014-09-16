_          = require 'lodash'
React      = require 'react/addons'
Icon       = require './Icon'
{li, span} = React.DOM
{classSet} = React.addons

StackListItem = React.createClass {

  render: ->
    classes = classSet {'stack-list-item': true, active: @props.isOpen}
    li {className: classes, onClick: @handleClick}, [
      Icon {name: 'stack'}
      span {className: 'stack-name'}, [@props.stack.name]
      span {className: 'stack-card-count'}, [@props.stack.cards.length]
    ]

  handleClick: ->
    Screen.openStack(@props.stack)

}

module.exports = StackListItem
