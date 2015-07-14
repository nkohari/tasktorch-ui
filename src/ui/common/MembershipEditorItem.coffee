#--------------------------------------------------------------------------------
React            = require 'react'
classSet         = require 'common/util/classSet'
PropTypes        = require 'ui/framework/PropTypes'
ShellContext     = require 'ui/framework/mixins/ShellContext'
Avatar           = React.createFactory(require 'ui/common/Avatar')
Icon             = React.createFactory(require 'ui/common/Icon')
Overlay          = React.createFactory(require 'ui/common/Overlay')
OverlayTrigger   = React.createFactory(require 'ui/common/OverlayTrigger')
{a, div, span}   = React.DOM
#--------------------------------------------------------------------------------

MembershipEditorItem = React.createClass {

  displayName: 'MembershipEditorItem'

  propTypes:
    user:          PropTypes.User
    allowEditSelf: PropTypes.bool
    isLeader:      PropTypes.bool
    addLeader:     PropTypes.func
    removeLeader:  PropTypes.func
    removeMember:  PropTypes.func

  mixins: [ShellContext]

  getDefaultProps: ->
    {allowEditSelf: true}

  componentWillMount: ->
    @isActiveUser = @getCurrentUser().id == @props.user?.id

  componentWillReceiveProps: (newProps) ->
    @isActiveUser = @getCurrentUser().id == newProps.user?.id

  render: ->

    if @isActiveUser
      name = "#{@props.user.name} (You)"
    else
      name = @props.user.name

    div {className: 'member'},
      Avatar {user: @props.user}
      span {className: 'member-name'}, name
      div {className: 'buttons'},
        @renderLeaderToggle()
        @renderRemoveTrigger()

  renderLeaderToggle: ->

    if not @props.isLeader
      a {className: 'leader-toggle trigger', onClick: @onLeaderToggleClicked},
        'Member'
    else if @isActiveUser and not @props.allowEditSelf
      overlay = Overlay {position: 'bottom right'}, "You can't remove yourself as a leader."
      OverlayTrigger {method: 'click', overlay},
        a {className: 'leader-toggle trigger'},
          Icon {name: 'secure'}
          'Leader'
    else
      a {className: 'leader-toggle trigger active', onClick: @onLeaderToggleClicked},
        Icon {name: 'secure'}
        'Leader'

  renderRemoveTrigger: ->

    if @isActiveUser and not @props.allowEditSelf
      overlay = Overlay {position: 'bottom right'}, "You can't remove yourself as a member."
      OverlayTrigger {method: 'click', overlay},
        a {className: 'trigger'},
          Icon {name: 'remove'}
    else
      a {className: 'trigger', onClick: @onRemoveClicked},
        Icon {name: 'remove'}

  onRemoveClicked: ->
    return if @isActiveUser and not @props.allowEditSelf
    @props.removeMember(@props.user)

  onLeaderToggleClicked: ->
    return if @isActiveUser and not @props.allowEditSelf
    if @props.isLeader
      @props.removeLeader(@props.user)
    else
      @props.addLeader(@props.user)

}

module.exports = MembershipEditorItem
