React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Avatar    = React.createFactory(require 'ui/common/Avatar')
{em}      = React.DOM

TeamWidget = React.createClass {

  displayName: 'TeamWidget'

  propTypes:
    team: PropTypes.Team

  render: ->
    em {}, @props.team.name

}

module.exports = TeamWidget
