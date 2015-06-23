#--------------------------------------------------------------------------------
_                      = require 'lodash'
React                  = require 'react'
KeyCode                = require 'ui/framework/KeyCode'
PropTypes              = require 'ui/framework/PropTypes'
Avatar                 = React.createFactory(require 'ui/common/Avatar')
Button                 = React.createFactory(require 'ui/common/Button')
LeaderToggle           = React.createFactory(require 'ui/common/LeaderToggle')
Icon                   = React.createFactory(require 'ui/common/Icon')
Input                  = React.createFactory(require 'ui/common/Input')
{a, div, span, ul, li} = React.DOM
#--------------------------------------------------------------------------------
require('./InviteEditor.styl')
#--------------------------------------------------------------------------------

InviteEditor = React.createClass {

  displayName: 'InviteEditor'

  props:
    org:      PropTypes.Org
    value:    PropTypes.arrayOf(PropTypes.object)
    onChange: PropTypes.func

  getInitialState: ->
    {currentEmail: ''}

  componentDidMount: ->
    @refs.input.focus()

  componentDidUpdate: ->
    node = @refs.list.getDOMNode()
    node.scrollTop = node.scrollHeight

  render: ->

    invites = _.map @props.value, (invite, index) =>
      li {key: index, className: 'invite'},
        span {className: 'number'}, index + 1
        Avatar {email: invite.email}
        span {className: 'email'}, invite.email
        LeaderToggle {value: invite.leader, onChange: @onLeaderToggled.bind(null, index)}
        a {className: 'remove', onClick: @onRemoveClicked.bind(null, index)},
          Icon {name: 'remove'}

    div {className: 'invite-editor'},
      div {className: 'add-invite'},
        Input {ref: 'input', icon: 'email', value: @state.currentEmail, @onKeyUp, @onChange}
        a {onClick: @onAddClicked},
          Icon {name: 'add'}
      ul {ref: 'list', className: 'invite-list'},
        invites

  onChange: (event) ->
    @setState {currentEmail: event.target.value}

  onKeyUp: (event) ->
    if event.which is KeyCode.RETURN
      event.stopPropagation()
      @addInvite(event.target.value)

  onAddClicked: ->
    @addInvite(@state.currentEmail)

  onLeaderToggled: (index) ->
    invites = _.clone(@props.value)
    invites[index].leader = !invites[index].leader
    @props.onChange(invites)

  onRemoveClicked: (index) ->
    invites = _.clone(@props.value)
    invites.splice(index, 1)
    @props.onChange(invites)

  addInvite: (email) ->
    return unless email?.length > 0
    invite = {email, leader: false}
    invites = _.clone(@props.value).concat [invite]
    @props.onChange(invites)
    @setState {currentEmail: ''}

}

module.exports = InviteEditor
