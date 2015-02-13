React              = require 'react'
PropTypes          = require 'framework/PropTypes'
Observe            = require 'framework/mixins/Observe'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
ActionCommand      = require 'framework/enums/ActionCommand'
Avatar             = React.createFactory(require 'ui/common/Avatar')
Icon               = React.createFactory(require 'ui/common/Icon')
Link               = React.createFactory(require 'ui/common/Link')

ActionOwner = React.createClass {

  displayName: 'ActionOwner'

  propTypes:
    action:      PropTypes.Action
    showCommand: PropTypes.func

  mixins: [Observe('actions', 'users')]

  componentDidMount: ->
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
      contents = Avatar {user: @state.user}
    else
      contents = Icon {name: 'assign'}

    Link {@isReady, className: 'owner', @onClick}, contents

  onClick: ->
    @props.showCommand(ActionCommand.ChangeOwner)

}

module.exports = ActionOwner
