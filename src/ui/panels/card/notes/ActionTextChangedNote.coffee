_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
Observe   = require 'framework/mixins/Observe'
ListItem  = React.createFactory(require 'ui/common/ListItem')
{span}    = React.DOM

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

    if @props.note.content.from?
      contents = @renderAsChange()
    else
      contents = @renderAsAdd()

    ListItem {@isReady, className: 'note activity action-text-changed'}, contents

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
