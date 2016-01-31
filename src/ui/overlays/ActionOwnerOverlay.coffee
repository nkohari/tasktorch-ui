#--------------------------------------------------------------------------------
_                           = require 'lodash'
React                       = require 'react'
UserChangedActionOwnerEvent = require 'events/ui/UserChangedActionOwnerEvent'
KeyCode                     = require 'ui/framework/KeyCode'
PropTypes                   = require 'ui/framework/PropTypes'
Actor                       = require 'ui/framework/mixins/Actor'
CachedState                 = require 'ui/framework/mixins/CachedState'
LocalStorage                = require 'ui/framework/mixins/LocalStorage'
IdentityContext             = require 'ui/framework/mixins/IdentityContext'
Avatar                      = React.createFactory(require 'ui/common/Avatar')
Icon                        = React.createFactory(require 'ui/common/Icon')
Input                       = React.createFactory(require 'ui/common/Input')
OptionList                  = React.createFactory(require 'ui/common/OptionList')
OptionListSeparator         = React.createFactory(require 'ui/common/OptionListSeparator')
Overlay                     = React.createFactory(require 'ui/common/Overlay')
EmptyOption                 = React.createFactory(require 'ui/options/EmptyOption')
UserOption                  = React.createFactory(require 'ui/options/UserOption')
{div, ul, li, span}         = React.DOM
#--------------------------------------------------------------------------------
require './ActionOwnerOverlay.styl'
#--------------------------------------------------------------------------------

NUM_RECENT_USERS = 5

ActionOwnerOverlay = React.createClass {

  displayName: 'ActionOwnerOverlay'

  propTypes:
    action:      PropTypes.Action
    hideOverlay: PropTypes.func

  mixins: [Actor, CachedState, LocalStorage, IdentityContext]

  getInitialState: ->
    {text: '', highlighted: undefined}

  getCachedState: (cache) ->
    userids = @getRecentUsers()
    if userids?.length > 0
      recentUsers = _.sortBy cache('users').getAll(userids), (u) -> u.name
    if @state?.text?.length > 0
      suggestedUsers = cache('suggestedUsers').get(@state.text)
    {recentUsers, suggestedUsers}

  componentDidMount: ->
    _.defer => @refs.input.focus()

  render: ->

    if @state.text?.length > 0
      if @state.suggestedUsers?.length > 0
        options = _.map @state.suggestedUsers, (user) =>
          UserOption {key: user.id, value: user}
      else
        options = [
          EmptyOption {}
        ]
    else
      options = [
        UserOption {key: 0, value: @getCurrentUser()}
        UserOption {key: 1, value: null}
      ]
      if @state.recentUsers?
        options = options.concat [
          OptionListSeparator {key: 'recent', text: 'Recent Users'}
        ].concat _.map @state.recentUsers, (user) =>
          UserOption {key: user.id, value: user}

    Overlay {className: 'action-owner-overlay', position: 'bottom right', arrow: true, hideOverlay: @props.hideOverlay},
      Input {ref: 'input', rightIcon: 'search', placeholder: 'Start typing to find users', value: @state.text, @onKeyDown, onChange: @onInputChanged}
      OptionList {ref: 'list', className: 'user-list', onSelect: @setActionOwner},
        options

  onKeyDown: (event) ->
    switch event.which
      when KeyCode.DOWN
        @refs.list.highlightNext()
        event.preventDefault()
      when KeyCode.UP
        @refs.list.highlightPrevious()
        event.preventDefault()
      when KeyCode.RETURN
        @setActionOwner(@refs.list.getValue())
        event.preventDefault()
      when KeyCode.ESCAPE
        @props.closeOverlay()
        event.preventDefault()

  onInputChanged: (event) ->
    @setState {text: event.target.value}, => @forceCacheSync()

  setActionOwner: (user) ->
    userid = if user? then user.id else null
    if userid?
      @addRecentUser(userid)
    if @props.action.user != userid
      @publish new UserChangedActionOwnerEvent(@props.action.id, userid)
    @props.hideOverlay()

  getRecentUsers: ->
    @getStorageSlot('ActionOwnerOverlay').get('recentUsers')

  addRecentUser: (userid) ->

    slot = @getStorageSlot('ActionOwnerOverlay')
    userids = slot.get('recentUsers') ? []

    return if @getCurrentUser().id == userid or _.includes(userids, userid)

    userids.shift()      if userids.length >= NUM_RECENT_USERS
    userids.push(userid) unless _.includes(userids, userid)
    
    slot.set('recentUsers', userids)

}

module.exports = ActionOwnerOverlay
