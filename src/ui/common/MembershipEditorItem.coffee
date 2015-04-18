React       = require 'react/addons'
PropTypes   = require 'ui/framework/PropTypes'
Avatar      = React.createFactory(require 'ui/common/Avatar')
Button      = React.createFactory(require 'ui/common/Button')
{div, span} = React.DOM

MembershipEditorItem = React.createClass {

  displayName: 'MembershipEditorItem'

  propTypes:
    user:         PropTypes.User
    isLeader:     PropTypes.bool
    removeMember: PropTypes.func

  render: ->

    div {className: 'member'},
      Avatar {user: @props.user}
      span {className: 'member-name'}, @props.user.name
      div {className: 'buttons'},
        Button {className: 'small', text: 'Make Leader'}
        Button {className: 'small', text: 'Remove Member', onClick: @onRemoveClicked}

  onRemoveClicked: ->
    @props.removeMember(@props.user)

}

module.exports = MembershipEditorItem
