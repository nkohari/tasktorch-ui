React            = require 'react/addons'
classSet         = require 'common/util/classSet'
PropTypes        = require 'ui/framework/PropTypes'
CurrentUserAware = require 'ui/framework/mixins/CurrentUserAware'
Avatar           = React.createFactory(require 'ui/common/Avatar')
Icon             = React.createFactory(require 'ui/common/Icon')
{a, div, span}   = React.DOM

MembershipEditorItem = React.createClass {

  displayName: 'MembershipEditorItem'

  propTypes:
    user:         PropTypes.User
    isLeader:     PropTypes.bool
    removeMember: PropTypes.func
    toggleLeader: PropTypes.func

  mixins: [CurrentUserAware]

  render: ->

    if @getCurrentUser().id == @props.user.id
      name = "#{@props.user.name} (You)"
    else
      name = @props.user.name

    div {className: 'member'},
      Avatar {user: @props.user}
      span {className: 'member-name'}, name
      div {className: 'buttons'},
        @renderLeaderToggle()
        a {className: 'trigger', onClick: @onRemoveClicked},
          Icon {name: 'remove'}

  renderLeaderToggle: ->

    if @props.isLeader
      a {className: 'leader-toggle trigger active', onClick: @onLeaderToggleClicked},
        Icon {name: 'secure'}
        'Leader'
    else
      a {className: 'leader-toggle trigger', onClick: @onLeaderToggleClicked},
        'Member'

  onRemoveClicked: ->
    @props.removeMember(@props.user)

  onLeaderToggleClicked: ->
    @props.toggleLeader(@props.user)

}

module.exports = MembershipEditorItem
