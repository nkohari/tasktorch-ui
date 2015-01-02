_                    = require 'lodash'
React                = require 'react'
CardContext          = require '../CardContext'
RestoreCommandButton = React.createFactory(require '../commandButtons/RestoreCommandButton')
{div}                = React.DOM

TrashCommandBar = React.createClass {

  displayName: 'TrashCommandBar'

  mixins: [CardContext]

  render: ->

    div {className: 'archive commands'}, [
      div {key: 'left', className: 'button-group'}, [
        RestoreCommandButton {key: 'restore'}
      ]
    ]

}

module.exports = TrashCommandBar
