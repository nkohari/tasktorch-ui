#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
UserOption = React.createFactory(require 'ui/options/UserOption')
TeamOption = React.createFactory(require 'ui/options/TeamOption')
{div}      = React.DOM
#--------------------------------------------------------------------------------

UserOrTeamOption = React.createClass {

  displayName: 'UserOrTeamOption'

  propTypes:
    type:          PropTypes.oneOf ['user', 'team']
    value:         PropTypes.oneOfType [PropTypes.User, PropTypes.Team]
    isHighlighted: PropTypes.bool

  render: ->
    props = _.omit(@props, 'type')
    switch @props.type
      when 'user' then UserOption(props)
      when 'team' then TeamOption(props)

}

module.exports = UserOrTeamOption
