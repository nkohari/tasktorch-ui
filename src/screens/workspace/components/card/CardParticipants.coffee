_                                 = require 'lodash'
React                             = require 'react'
PropTypes                         = require 'common/PropTypes'
Observe                           = require 'mixins/Observe'
CardParticipantListDisplayedEvent = require 'events/display/CardParticipantListDisplayedEvent'
Avatar                            = React.createFactory(require 'common/Avatar')
{div, span, ul, li}               = React.DOM

CardParticipants = React.createClass {

  #--------------------------------------------------------------------------------

  displayName: 'CardParticipants'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe('users')]

  #--------------------------------------------------------------------------------

  componentWillMount: ->
    @publish new CardParticipantListDisplayedEvent(@props.card.id, @props.card.participants)

  componentWillReceiveProps: (newProps) ->
    unless _.isEqual(@props.card.participants, newProps.card.participants)
      @publish new CardParticipantListDisplayedEvent(newProps.card.id, newProps.card.participants)

  #--------------------------------------------------------------------------------

  sync: (stores) ->
    return {
      currentUser:  stores.users.getCurrentUser()
      owner:        stores.users.get(@props.card.owner) if @props.card.owner?
      participants: stores.users.getMany(@props.card.participants)
    }

  ready: ->
    return {
      currentUser:  @state.currentUser?
      owner:        (@state.owner? or not @props.card.owner?)
      participants: @state.participants?
    }

  render: ->
    ul {className: 'participants'}, @contents()

  children: ->
    _.map @state.participants, (user) =>
      li {key: "user-#{user.id}", className: 'participant'}, [
        Avatar {key: 'avatar', user, size: 32}
      ] 

  #--------------------------------------------------------------------------------
}

module.exports = CardParticipants
