_                      = require 'lodash'
React                  = require 'react'
PropTypes              = require 'framework/PropTypes'
Observe                = require 'framework/mixins/Observe'
ChangeCardTitleRequest = require 'requests/ChangeCardTitleRequest'
EditableText           = React.createFactory(require 'ui/common/EditableText')
{div}                  = React.DOM

CardTitle = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardTitle'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe()]

  # Lifecycle ---------------------------------------------------------------------

  componentDidMount: ->
    @refs.text.getDOMNode().focus() unless @props.card.title

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'title'}, [
      EditableText {
        ref:         'text'
        placeholder: 'Untitled Card'
        value:       @props.card.title
        save:        @onTitleChanged
      }
    ]

  # Events ------------------------------------------------------------------------

  onTitleChanged: (title) ->
    @execute new ChangeCardTitleRequest(@props.card, title)

  #--------------------------------------------------------------------------------

}

module.exports = CardTitle
