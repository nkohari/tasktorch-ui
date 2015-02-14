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
      when 'user' then @renderAsUser(@props.value)
      when 'team' then @renderAsTeam(@props.value)

  renderAsUser: (user) ->
    div {},
      Avatar {user}
      user.name

  renderAsTeam: (team) ->
    div {},
      Icon {name: 'users'}
      team.name

}

module.exports = UserOrTeamSelectorOption