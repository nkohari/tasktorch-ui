_            = require 'lodash'
React        = require 'react'
Flux         = require '../../mixins/Flux'
Panel        = React.createFactory(require '../../common/Panel')
TeamListItem = React.createFactory(require './TeamListItem')
{ul}         = React.DOM

TeamList = React.createClass {

  displayName: 'TeamList'

  mixins: [Flux('teams')]

  getStateFromStores: (stores) ->
    return {
      teams: stores.teams.getAllTeams()
    }

  render: ->
    items = _.map @state.teams, (team) =>
      TeamListItem {key: "team-#{team.id}", team}
    ul {className: 'team-list'}, items

}

module.exports = TeamList
