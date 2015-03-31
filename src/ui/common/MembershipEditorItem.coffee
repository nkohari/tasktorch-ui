React        = require 'react/addons'
PropTypes    = require 'ui/framework/PropTypes'
Avatar       = React.createFactory(require 'ui/common/Avatar')
{div, input} = React.DOM

MembershipEditorItem = React.createClass {

  displayName: 'MembershipEditorItem'

  propTypes:
    user:     PropTypes.User
    isLeader: PropTypes.bool  

  render: ->

    div {className: 'member'},
      Avatar {user: @props.user}
      div {className: 'username'}, @props.user.name
      div {className: 'level'},
        input {type: 'radio', name: @props.user.id}, 'Member'
        input {type: 'radio', name: @props.user.id}, 'Leader'

}

module.exports = MembershipEditorItem
