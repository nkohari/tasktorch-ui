_                          = require 'lodash'
React                      = require 'react'
PropTypes                  = require 'framework/PropTypes'
Observe                    = require 'framework/mixins/Observe'
CardNoteListDisplayedEvent = require 'events/display/CardNoteListDisplayedEvent'
Block                      = React.createFactory(require 'ui/common/Block')
Frame                      = React.createFactory(require 'ui/common/Frame')
List                       = React.createFactory(require 'ui/common/List')
CardNoteGroup              = React.createFactory(require 'ui/panels/card/CardNoteGroup')

CardConversation = React.createClass {

  displayName: 'CardConversation'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe('notes')]

  componentDidMount: ->
    @publish new CardNoteListDisplayedEvent(@props.card.id)

  componentWillReceiveProps: (newProps) ->
    unless @props.card.id == newProps.card.id
      @publish new CardNoteListDisplayedEvent(newProps.card.id)

  sync: (stores) ->
    {notes: stores.notes.getAllByCard(@props.card.id)}

  isReady: ->
    @state.notes?

  render: ->

    groups = _.map @createGroups(@state.notes), (group) =>
      CardNoteGroup {id: _.first(group.notes).id, card: @props.card, userid: group.user, notes: group.notes}

    Frame {@isReady, className: 'conversation'},
      List {className: 'notes'}, groups

  createGroups: (notes) ->
    groups = []
    currentGroup = undefined
    currentNote  = undefined
    shouldStartNewGroup = (note) ->
      return true unless currentGroup? and currentNote?
      return true if note.user != currentNote.user
      return true if note.getTimeDifference(currentNote) > 60*5*1000 # 5 minutes
    for note in notes
      if shouldStartNewGroup(note)
        group = {user: note.user, notes: [note], time: note.time}
        groups.push(group)
        currentGroup = group
      else
        currentGroup.notes.push(note)
      currentNote = note
    return groups

  #--------------------------------------------------------------------------------

}

module.exports = CardConversation
