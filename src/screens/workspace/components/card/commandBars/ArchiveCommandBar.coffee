_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'common/PropTypes'
CardContext          = require '../CardContext'
RestoreCommandButton = React.createFactory(require '../commandButtons/RestoreCommandButton')
DeleteCommandButton  = React.createFactory(require '../commandButtons/DeleteCommandButton')
{div}                = React.DOM

ArchiveCommandBar = React.createClass {

  displayName: 'ArchiveCommandBar'

  propTypes:
    card: PropTypes.Card

  mixins: [CardContext]

  render: ->

    div {className: 'archive commands'}, [
      div {key: 'left', className: 'button-group'}, [
        RestoreCommandButton {key: 'restore'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        DeleteCommandButton {key: 'delete'}
      ]
    ]

}

module.exports = ArchiveCommandBar
