_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
Constants           = require 'framework/Constants'
SetCardTitleRequest = require 'requests/SetCardTitleRequest'
Text                = React.createFactory(require 'common/Text')
{div}               = React.DOM

CardTitle = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardTitle'

  propTypes: PropTypes.Card

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
    request = new SetCardTitleRequest(@props.card, title)
    request.execute()

  #--------------------------------------------------------------------------------

}

module.exports = CardTitle
