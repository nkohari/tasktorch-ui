_                               = require 'lodash'
React                           = require 'react'
PropTypes                       = require 'common/PropTypes'
Observe                         = require 'mixins/Observe'
CardFollowersListDisplayedEvent = require 'events/display/CardFollowersListDisplayedEvent'
Avatar                          = React.createFactory(require 'common/Avatar')
{div, span, ul, li}             = React.DOM

CardFollowersList = React.createClass {

  #--------------------------------------------------------------------------------

  displayName: 'CardFollowersList'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe('users')]

  #--------------------------------------------------------------------------------

  componentWillMount: ->
    @publish new CardFollowersListDisplayedEvent(@props.card.id, @props.card.followers)

  componentWillReceiveProps: (newProps) ->
    unless _.isEqual(@props.card.followers, newProps.card.followers)
      @publish new CardFollowersListDisplayedEvent(newProps.card.id, newProps.card.followers)

  #--------------------------------------------------------------------------------

  sync: (stores) ->
    return {
      currentUser: stores.users.getCurrentUser()
      owner:       stores.users.get(@props.card.owner) if @props.card.owner?
      users:       stores.users.getMany(@props.card.followers)
    }

  ready: ->
    return {
      currentUser: @state.currentUser?
      owner:       (@state.owner? or not @props.card.owner?)
      users:       @state.users?
    }

  render: ->
    ul {className: 'followers'}, @contents()

  children: ->
    _.map @state.users, (user) =>
      li {key: "user-#{user.id}", className: 'follower'}, [
        Avatar {key: 'avatar', user, size: 32}
      ] 

  #--------------------------------------------------------------------------------
}

module.exports = CardFollowersList
