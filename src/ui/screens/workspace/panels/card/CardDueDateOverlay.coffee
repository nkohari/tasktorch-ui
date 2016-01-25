#--------------------------------------------------------------------------------
_                           = require 'lodash'
React                       = require 'react'
UserChangedCardDueDateEvent = require 'events/ui/UserChangedCardDueDateEvent'
PropTypes                   = require 'ui/framework/PropTypes'
Actor                       = require 'ui/framework/mixins/Actor'
CachedState                 = require 'ui/framework/mixins/CachedState'
Button                      = React.createFactory(require 'ui/common/Button')
DatePicker                  = React.createFactory(require 'ui/common/DatePicker')
Overlay                     = React.createFactory(require 'ui/common/Overlay')
{div, ul, li}               = React.DOM
#--------------------------------------------------------------------------------
require './CardDueDateOverlay.styl'
#--------------------------------------------------------------------------------

CardDueDateOverlay = React.createClass {

  displayName: 'CardDueDateOverlay'

  propTypes:
    card:        PropTypes.Card
    hideOverlay: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    date:    if @props.card.due? then new Date(@props.card.due) else new Date()
    isValid: false
  }

  componentDidMount: ->
    @refs.picker.focus()

  render: ->

    Overlay {className: 'card-due-overlay', arrow: true, fixed: true, hideOverlay: @props.hideOverlay},
      DatePicker {
        ref: 'picker'
        value: @state.date
        @onChange
      }
      div {className: 'buttons'},
        div {className: 'buttons-left'},
          Button {className: 'small', text: 'Remove due date', onClick: @clearDueDate}
        div {className: 'buttons-right'},
          Button {className: 'small', text: 'OK', disabled: !@isValid(), onClick: @saveDueDate}
          Button {className: 'small', text: 'Cancel', onClick: @props.hideOverlay}

  onChange: (date) ->
    @setState {date}

  isValid: ->
    @state.date?

  clearDueDate: ->
    @publish new UserChangedCardDueDateEvent(@props.card.id, null)
    @props.hideOverlay()

  saveDueDate: ->
    @publish new UserChangedCardDueDateEvent(@props.card.id, @state.date)
    @props.hideOverlay()

}

module.exports = CardDueDateOverlay
