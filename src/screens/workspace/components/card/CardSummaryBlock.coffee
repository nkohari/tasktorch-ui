React                    = require 'react'
PropTypes                = require 'common/PropTypes'
Observe                  = require 'mixins/Observe'
ChangeCardSummaryRequest = require 'requests/ChangeCardSummaryRequest'
MultilineText            = React.createFactory(require 'common/MultilineText')
CardBlockHeader          = React.createFactory(require './CardBlockHeader')
{div}                    = React.DOM

CardSummaryBlock = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardSummaryBlock'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe()]

  getInitialState: ->
    {expanded: true}

  # Rendering ---------------------------------------------------------------------

  render: ->
    
    classes = ['summary', 'block']
    classes.push('expanded') if @state.expanded

    div {className: classes.join(' ')}, [
      @renderHeader()
      @renderContents() if @state.expanded
    ]

  renderHeader: ->
    CardBlockHeader {key: 'header', expanded: @state.expanded, @onToggleClicked}, ['Summary']

  renderContents: ->
    div {className: 'contents'}, [
      MultilineText {
        key:         'text'
        className:   'editable'
        placeholder: 'Card Summary'
        value:       @props.card.summary
        save:        @onSummaryChanged
      }
    ]

  # Events ------------------------------------------------------------------------

  onSummaryChanged: (value) ->
    @execute new ChangeCardSummaryRequest(@props.card, value)

  onToggleClicked: ->
    @setState {expanded: !@state.expanded}

  #--------------------------------------------------------------------------------
}

module.exports = CardSummaryBlock
