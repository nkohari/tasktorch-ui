_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'common/PropTypes'
Observe              = require 'mixins/Observe'
UserDisplayedEvent   = require 'events/display/UserDisplayedEvent'
{li}                 = React.DOM
CardCreatedNote      = React.createFactory(require './notes/CardCreatedNote')
CardTitleChangedNote = React.createFactory(require './notes/CardTitleChangedNote')
CardBodyChangedNote  = React.createFactory(require './notes/CardBodyChangedNote')

componentFactory = (path) ->
  return (name) ->
    React.createFactory("#{path}/#{name}")

CardNoteListItem = React.createClass {

  displayName: 'CardNoteListItem'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note

  mixins: [Observe('users')]

  componentWillMount: ->
    @publish new UserDisplayedEvent(@props.note.user)

  componentWillReceiveProps: (newProps) ->
    if @props.note.user != newProps.note.user
      @publish new UserDisplayedEvent(newProps.note.user)

  sync: (stores) ->
    {user: stores.users.get(@props.note.user)}

  ready: ->
    {user: @state.user?}

  render: ->
    li {className: 'note'}, @contents()

  children: ->
    props = {card: @props.card, note: @props.note, user: @state.user}
    switch @props.note.type
      when 'CardCreated'      then return CardCreatedNote(props)
      when 'CardTitleChanged' then return CardTitleChangedNote(props)
      when 'CardBodyChanged'  then return CardBodyChangedNote(props)

}

module.exports = CardNoteListItem
