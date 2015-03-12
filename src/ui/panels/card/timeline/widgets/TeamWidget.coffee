React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{em}      = React.DOM

TeamWidget = React.createClass {

  displayName: 'TeamWidget'

  propTypes:
    team: PropTypes.Team

  render: ->
    em {className: 'team-widget'},
      Icon {name: 'team'}
      @props.team.name

}

module.exports = TeamWidget
