_                      = require 'lodash'
React                  = require 'react'
PropTypes              = require 'common/PropTypes'
Observe                = require 'mixins/Observe'
ChangeCardTitleRequest = require 'requests/ChangeCardTitleRequest'
Text                   = React.createFactory(require 'common/Text')
{div}                  = React.DOM

CardTitle = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardTitle'

  propTypes: PropTypes.Card

  mixins: [Observe()]

  # Lifecycle ---------------------------------------------------------------------

  componentDidMount: ->
    @refs.text.getDOMNode().focus() unless @props.card.title

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'title'}, [
      Text {
        key: 'text'
        ref: 'text'
        placeholder: 'Untitled Card'
        value: @props.card.title
        save: @onTitleChanged
      }
    ]

  # Events ------------------------------------------------------------------------

  onTitleChanged: (title) ->
    @execute new ChangeCardTitleRequest(@props.card, title)

  #--------------------------------------------------------------------------------

}

module.exports = CardTitle
