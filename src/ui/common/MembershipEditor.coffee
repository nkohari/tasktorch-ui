#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
UserSearchBox        = React.createFactory(require 'ui/common/UserSearchBox')
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
        UserSearchBox {ref: 'search', onOptionSelected: @props.addMember}

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
    @refs.search.focus() if @refs.search?

}

module.exports = MembershipEditor
