_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
Constants           = require 'framework/Constants'
Observe             = require 'mixins/Observe'
SetCardTitleRequest = require 'requests/SetCardTitleRequest'
Text                = React.createFactory(require 'common/Text')
{div}               = React.DOM

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
        placeholder: Constants.untitledCard
        value: @props.card.title
        save: @setCardTitle
      }
    ]

  # Events ------------------------------------------------------------------------

  setCardTitle: (title) ->
    @execute new SetCardTitleRequest(@props.card, title)

  #--------------------------------------------------------------------------------

}

module.exports = CardTitle
