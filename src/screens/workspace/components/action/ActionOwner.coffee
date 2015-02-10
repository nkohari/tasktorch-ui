React              = require 'react'
PropTypes          = require 'common/PropTypes'
Observe            = require 'mixins/Observe'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
ActionCommand      = require 'framework/enums/ActionCommand'
Avatar             = React.createFactory(require 'common/Avatar')
Frame              = React.createFactory(require 'common/Frame')
Icon               = React.createFactory(require 'common/Icon')
{a}                = React.DOM

ActionOwner = React.createClass {

  displayName: 'ActionOwner'

  propTypes:
    action:      PropTypes.Action
    showCommand: PropTypes.func

  mixins: [Observe('actions', 'users')]

  componentWillMount: ->
    @publish new UserDisplayedEvent(@props.action.owner) if @props.action.owner?

  componentWillReceiveProps: (newProps) ->
    prev = @props.action
    curr = newProps.action
    @publish new UserDisplayedEvent(curr.owner) if curr.owner? and curr.owner != prev.owner

  sync: (stores) ->
    if @props.action.owner?
      user = stores.users.get(@props.action.owner)
    else
      user = null
    {user}

  isReady: ->
    @state.user? or not @props.action.owner?

  render: ->

    if @state.user?
      contents = Avatar {key: 'avatar', user: @state.user}
    else
      contents = Icon {key: 'icon', name: 'assign'}

    Frame {@isReady, component: 'a', className: 'owner', @onClick}, [contents]

  onClick: ->
    @props.showCommand(ActionCommand.ChangeOwner)

}

module.exports = ActionOwner
