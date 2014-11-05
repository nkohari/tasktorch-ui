React  = require 'react'
{span} = React.DOM

MenuTrigger = React.createClass {

  displayName: 'MenuTrigger'

  render: ->
    span {className: "menu-trigger"}, ['\uE764']

}

module.exports = MenuTrigger
