_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'common/PropTypes'
Observe    = require 'mixins/Observe'
{li, span} = React.DOM

ActionTextChangedNote = React.createClass {

  displayName: 'ActionTextChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [Observe('actions')]

  sync: (stores) ->
    {action: stores.actions.get(@props.note.content.action)}

  isReady: ->
    @state.action?

  render: ->
    Frame {@isReady, component: 'li', className: 'note activity action-text-changed'}, @renderContents()

  renderContents: ->
    if @props.note.content.from?
      @renderAsChange()
    else
      @renderAsAdd()

  renderAsAdd: -> [
    "Added an action titled "
    span {className: 'value'}, [@props.note.content.to]
  ]

  renderAsChange: -> [
    "Changed the text of the action "
    span {className: 'value'}, [@props.note.content.from]
    " to "
    span {className: 'value'}, [@props.note.content.to]
  ]

}

module.exports = ActionTextChangedNote
