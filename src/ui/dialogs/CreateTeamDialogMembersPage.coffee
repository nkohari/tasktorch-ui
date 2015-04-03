React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Field            = React.createFactory(require 'ui/common/Field')
FieldGroup       = React.createFactory(require 'ui/common/FieldGroup')
MembershipEditor = React.createFactory(require 'ui/common/MembershipEditor')
{div}            = React.DOM

CreateTeamDialogMembersPage = React.createClass {

  displayName: 'CreateTeamDialogMembersPage'

  props:
    members:  PropTypes.arrayOf(PropTypes.id)
    title:    PropTypes.string
    onChange: PropTypes.func

  getInitialState: -> {
    members: @props.members
  }

  render: ->

    FieldGroup {},
      Field {label: 'Members'},
        MembershipEditor {members: @state.members}

}

module.exports = CreateTeamDialogMembersPage
