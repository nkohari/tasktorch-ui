_                             = require 'lodash'
React                         = require 'react'
Router                        = require 'react-router'
PropTypes                     = require 'framework/PropTypes'
StackType                     = require 'framework/enums/StackType'
Observe                       = require 'framework/mixins/Observe'
Url                           = require 'framework/Url'
MyStacksDisplayedEvent        = require 'events/display/MyStacksDisplayedEvent'
MyFollowedCardsDisplayedEvent = require 'events/display/MyFollowedCardsDisplayedEvent'
Frame                         = React.createFactory(require 'ui/common/Frame')
FollowingToggleButton         = React.createFactory(require 'ui/shell/footer/FollowingToggleButton')
SpecialStackToggleButton      = React.createFactory(require 'ui/shell/footer/SpecialStackToggleButton')

BottomLeftCorner = React.createClass {

  displayName: 'BottomLeftCorner'

  mixins: [
    Observe('cards', 'stacks')
    Router.State
  ]

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  componentDidMount: ->
    @publish new MyStacksDisplayedEvent()
    @publish new MyFollowedCardsDisplayedEvent()

  sync: (stores) ->
    {currentUser} = @props
    if currentUser?
      inbox = stores.stacks.getSpecialStackByUser(currentUser.id, StackType.Inbox)
      queue = stores.stacks.getSpecialStackByUser(currentUser.id, StackType.Queue)
      followedCards = stores.cards.getMyFollowedCards(currentUser.id)
    {inbox, queue, followedCards}

  isReady: ->
    @state.inbox? and @state.queue? and @state.followedCards?

  render: ->

    Frame {@isReady, className: 'bottom-left'},
      FollowingToggleButton    {cards: @state.followedCards}
      SpecialStackToggleButton {icon: 'inbox', hotkey: 'i', stack: @state.inbox}
      SpecialStackToggleButton {icon: 'queue', hotkey: 'q', stack: @state.queue}

}

module.exports = BottomLeftCorner
