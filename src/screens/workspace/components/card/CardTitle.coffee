_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
Constants           = require 'framework/Constants'
SetCardTitleRequest = require 'requests/SetCardTitleRequest'
Text                = React.createFactory(require 'common/Text')
{div}               = React.DOM

CardTitle = React.createClass {

  displayName: 'CardTitle'

  mixins: [Observe()]

  componentDidMount: ->
    @refs.text.getDOMNode().focus() unless @props.card.title

  render: ->
    div {className: 'title'}, [
      Text {key: 'text', ref: 'text', placeholder: Constants.untitledCard, value: @props.card.title, save: @saveTitle}
    ]

  saveTitle: (title) ->
    @execute new SetCardTitleRequest(@props.card, title)

}

module.exports = CardTitle
