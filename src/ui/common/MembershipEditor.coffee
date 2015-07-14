#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
UserSelector         = React.createFactory(require 'ui/common/UserSelector')
MembershipEditorItem = React.createFactory(require 'ui/common/MembershipEditorItem')
{div}                = React.DOM
#--------------------------------------------------------------------------------
require './MembershipEditor.styl'
#--------------------------------------------------------------------------------

MembershipEditor = React.createClass {

  displayName: 'MembershipEditor'

  propTypes:
    leaders:       PropTypes.arrayOf(PropTypes.User)
    members:       PropTypes.arrayOf(PropTypes.User)
    addLeader:     PropTypes.func
    addMember:     PropTypes.func
    removeLeader:  PropTypes.func
    removeMember:  PropTypes.func
    allowEditSelf: PropTypes.bool

  getDefaultProps: ->
    {members: [], leaders: [], allowEditSelf: true}

  render: ->

    if @props.addMember?
      addForm = div {className: 'member-search'},
        UserSelector {ref: 'selector', onOptionSelected: @props.addMember}

    members = _.map @props.members, (user) =>
      MembershipEditorItem {
        key: user.id
        user
        isLeader:      _.contains(@props.leaders, user.id)
        allowEditSelf: @props.allowEditSelf
        addLeader:     @props.addLeader
        removeLeader:  @props.removeLeader
        removeMember:  @props.removeMember
      }

    div {className: 'membership-editor'},
      addForm
      div {className: 'member-list'}, members

  focus: ->
    @refs.selector.focus() if @refs.selector?

}

module.exports = MembershipEditor
