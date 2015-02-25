_                        = require 'lodash'
React                    = require 'react'
StackType                = require 'data/enums/StackType'
PropTypes                = require 'ui/framework/PropTypes'
CachedState              = require 'ui/framework/mixins/CachedState'
Frame                    = React.createFactory(require 'ui/common/Frame')
FollowingToggleButton    = React.createFactory(require 'ui/shell/footer/FollowingToggleButton')
SpecialStackToggleButton = React.createFactory(require 'ui/shell/footer/SpecialStackToggleButton')

BottomLeftCorner = React.createClass {

  displayName: 'BottomLeftCorner'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    myStacks = cache('myStacks').get()
    if myStacks?
      inbox = _.find(myStacks, (stack) -> stack.type == StackType.Inbox)
      queue = _.find(myStacks, (stack) -> stack.type == StackType.Queue)
    followedCards = cache('myFollowedCards').get()
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
