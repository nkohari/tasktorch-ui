React                     = require 'react'
PropTypes                 = require 'framework/PropTypes'
UserDisplayedEvent        = require 'events/display/UserDisplayedEvent'
Observe                   = require 'framework/mixins/Observe'
ChangeActionOwnerRequest  = require 'requests/ChangeActionOwnerRequest'
Button                    = React.createFactory(require 'ui/common/Button')
SuggestingSelector        = React.createFactory(require 'ui/common/SuggestingSelector')
UserSelectorOption        = React.createFactory(require 'ui/common/UserSelectorOption')
{div}                     = React.DOM

ChangeActionOwnerCommandPanel = React.createClass {

  displayName: 'ChangeActionOwnerCommandPanel'

  propTypes:
    action:      PropTypes.Action
    hideCommand: PropTypes.func

  mixins: [Observe('users')]

  getInitialState: ->
    {userid: @props.action.owner, user: undefined}

  componentDidMount: ->
    @publish new UserDisplayedEvent(@props.action.owner) if @props.action.owner?

  componentWillReceiveProps: (newProps) ->
    prev = @props.action
    curr = newProps.action
    @publish new UserDisplayedEvent(curr.owner) if curr.owner? and curr.owner != prev.owner

  sync: (stores) ->
    user = stores.users.get(@state.userid) if @state?.userid?
    {user}

  render: ->
    div {className: 'action-command'}, [
      SuggestingSelector {
        option:        UserSelectorOption
        suggest:       'user'
        selection:     @state.user
        selectionType: 'user'
        onChange:      @onUserSelected
      }
      div {className: 'buttons'}, [
        Button {key: 'ok',     className: 'small', text: 'OK',     onClick: @onOkClicked}
        Button {key: 'cancel', className: 'small', text: 'Cancel', onClick: @onCancelClicked}
      ]
    ]

  onUserSelected: (user) ->
    @setState {userid: user.id, user: user}

  onOkClicked: ->
    @execute new ChangeActionOwnerRequest(@props.action, @state.userid)
    @props.hideCommand()

  onCancelClicked: ->
    @props.hideCommand()

}

module.exports = ChangeActionOwnerCommandPanel
