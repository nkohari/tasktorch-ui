React                    = require 'react'
PropTypes                = require 'framework/PropTypes'
Observe                  = require 'framework/mixins/Observe'
ChangeCardSummaryRequest = require 'requests/ChangeCardSummaryRequest'
EditableTextBlock        = React.createFactory(require 'ui/common/EditableTextBlock')
CardBlockHeader          = React.createFactory(require 'ui/panels/card/CardBlockHeader')
{div}                    = React.DOM

CardSummaryBlock = React.createClass {

  displayName: 'CardSummaryBlock'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe()]

  getInitialState: ->
    {expanded: true}

  render: ->
    
    classes = ['summary', 'block']
    classes.push('expanded') if @state.expanded

    div {className: classes.join(' ')},
      CardBlockHeader {expanded: @state.expanded, @onToggleClicked}, 'Summary'
      @renderContents() if @state.expanded

  renderContents: ->
    div {className: 'contents'},
      EditableTextBlock {
        className:   'editable'
        placeholder: 'Card Summary'
        value:       @props.card.summary
        save:        @onSummaryChanged
      }

  onSummaryChanged: (value) ->
    @execute new ChangeCardSummaryRequest(@props.card, value)

  onToggleClicked: ->
    @setState {expanded: !@state.expanded}

}

module.exports = CardSummaryBlock
