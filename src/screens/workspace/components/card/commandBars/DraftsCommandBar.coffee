_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
CardContext         = require '../CardContext'
AcceptCommandButton = React.createFactory(require '../commandButtons/AcceptCommandButton')
PassCommandButton   = React.createFactory(require '../commandButtons/PassCommandButton')
DeleteCommandButton = React.createFactory(require '../commandButtons/DeleteCommandButton')
{div}               = React.DOM

DraftsCommandBar = React.createClass {

  displayName: 'DraftsCommandBar'

  propTypes:
    card: PropTypes.Card

  mixins: [CardContext]

  render: ->

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        AcceptCommandButton {key: 'accept'}
        PassCommandButton   {key: 'pass'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        DeleteCommandButton {key: 'delete'}
      ]
    ]

}

module.exports = DraftsCommandBar
