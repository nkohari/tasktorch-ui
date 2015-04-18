_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
UserSelector         = React.createFactory(require 'ui/common/UserSelector')
MembershipEditorItem = React.createFactory(require 'ui/common/MembershipEditorItem')
{div}                = React.DOM

MembershipEditor = React.createClass {

  displayName: 'MembershipEditor'

  propTypes:
    leaders: PropTypes.arrayOf(PropTypes.id)
    members: PropTypes.arrayOf(PropTypes.id)

  mixins: [CachedState]

  getInitialState: ->
    {leaders: [], members: []}

  getCachedState: (cache) ->
    return {
      users: cache('users').getAll(@state.members) if @state?.members?
    }

  render: ->

    if @state.users?
      lookup = _.indexBy(@state.users, 'id')
      members = _.map @state.members, (id) =>
        user = lookup[id]
        return unless user?
        isLeader = _.contains(@state.leaders, id)
        MembershipEditorItem {key: id, user, isLeader, @removeMember}

    div {className: 'membership-editor'},
      UserSelector {onOptionSelected: @addMember}
      div {className: 'member-list'}, members

  addMember: (user) ->
    members = @state.members.concat(user.id)
    @setState {members}, => @forceCacheSync()

  removeMember: (user) ->
    members = _.without(@state.members, user.id)
    @setState {members}, => @forceCacheSync()

}

module.exports = MembershipEditor