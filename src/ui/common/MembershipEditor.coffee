_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
SuggestingSelector = React.createFactory(require 'ui/common/SuggestingSelector')
UserSelectorOption = React.createFactory(require 'ui/common/UserSelectorOption')
{div}              = React.DOM

MembershipEditor = React.createClass {

  displayName: 'MembershipEditor'

  propTypes:
    members: PropTypes.arrayOf(PropTypes.id)
    leaders: PropTypes.arrayOf(PropTypes.id)

  mixins: [CachedState]

  getDefaultProps: -> {
    members: []
    leaders: []
  }

  getCachedState: (cache) -> {
    users: cache('users').getAll(@props.members)
  }

  render: ->

    if @state.users?
      lookup = _.indexBy(@state.users, 'id')
      users = _.map @props.members, (id) =>
        user     = lookup[id]
        isLeader = _.contains(@props.leaders, id)
        MembershipEditorItem {key: id, user, isLeader}

    div {className: 'membership-editor'},
      SuggestingSelector {
        option:   UserSelectorOption
        suggest:  'user'
        onChange: @onUserSelected
      }
      users

  onUserSelected: (user) ->
    console.log(user)

}

module.exports = MembershipEditor
