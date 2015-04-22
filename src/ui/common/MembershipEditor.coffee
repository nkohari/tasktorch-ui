_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
UserSelector         = React.createFactory(require 'ui/common/UserSelector')
MembershipEditorItem = React.createFactory(require 'ui/common/MembershipEditorItem')
{div}                = React.DOM

MembershipEditor = React.createClass {

  displayName: 'MembershipEditor'

  propTypes:
    leaders:      PropTypes.arrayOf(PropTypes.User)
    members:      PropTypes.arrayOf(PropTypes.User)
    addLeader:    PropTypes.func
    addMember:    PropTypes.func
    removeLeader: PropTypes.func
    removeMember: PropTypes.func

  getDefaultProps: ->
    {members: [], leaders: []}

  render: ->

    members = _.map @props.members, (user) =>
      MembershipEditorItem {
        key: user.id
        user
        isLeader:     _.contains(@props.leaders, user)
        addLeader:    @props.addLeader
        removeLeader: @props.removeLeader
        removeMember: @props.removeMember
      }

    div {className: 'membership-editor'},
      div {className: 'member-search'},
        UserSelector {ref: 'selector', onOptionSelected: @props.addMember}
      div {className: 'member-list'}, members

  focus: ->
    @refs.selector.focus()

}

module.exports = MembershipEditor
