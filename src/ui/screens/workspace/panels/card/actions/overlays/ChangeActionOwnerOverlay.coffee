React                       = require 'react'
PropTypes                   = require 'ui/framework/PropTypes'
CachedState                 = require 'ui/framework/mixins/CachedState'
Actor                       = require 'ui/framework/mixins/Actor'
UserChangedActionOwnerEvent = require 'events/ui/UserChangedActionOwnerEvent'
Button                      = React.createFactory(require 'ui/common/Button')
Overlay                     = React.createFactory(require 'ui/common/Overlay')
SuggestingSelector          = React.createFactory(require 'ui/common/SuggestingSelector')
UserSelectorOption          = React.createFactory(require 'ui/common/UserSelectorOption')
{div}                       = React.DOM

ChangeActionOwnerOverlay = React.createClass {

  displayName: 'ChangeActionOwnerOverlay'

  propTypes:
    action:      PropTypes.Action
    hideOverlay: PropTypes.func

  mixins: [Actor, CachedState]

  getInitialState: ->
    {userid: @props.action.user}

  getCachedState: (cache) -> {
    user: cache('users').get(@state.userid) if @state?.userid?
  }

  render: ->
    
    Overlay {arrow: true},
      SuggestingSelector {
        option:        UserSelectorOption
        placeholder:   'Select a user'
        suggest:       'user'
        selection:     @state.user
        selectionType: 'user'
        onChange:      @onUserSelected
      }
      div {className: 'buttons'},
        Button {className: 'small', text: 'OK',     onClick: @onOkClicked}
        Button {className: 'small', text: 'Cancel', onClick: @onCancelClicked}

  onUserSelected: (user) ->
    @setState {userid: user.id, user: user}

  onOkClicked: ->
    @publish new UserChangedActionOwnerEvent(@props.action.id, @state.userid)
    @props.hideOverlay()

  onCancelClicked: ->
    @props.hideOverlay()

}

module.exports = ChangeActionOwnerOverlay
