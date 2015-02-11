React     = require 'react'
PropTypes = require 'framework/PropTypes'
Avatar    = React.createFactory(require 'ui/common/Avatar')
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

UserOrTeamSelectorOption = React.createClass {

  displayName: 'UserOrTeamSelectorOption'

  propTypes:
    type:  PropTypes.oneOf ['user', 'team']
    value: PropTypes.oneOfType [PropTypes.User, PropTypes.Team]

  render: ->
    switch @props.type
      when 'user' then contents = @renderUser(@props.value)
      when 'team' then contents = @renderTeam(@props.value)
    div {}, contents

  renderUser: (user) -> [
    Avatar {key: 'avatar', user}
    user.name
  ]

  renderTeam: (team) -> [
    Icon {key: 'icon', name: 'users'}
    team.name
  ]

}

module.exports = UserOrTeamSelectorOption
