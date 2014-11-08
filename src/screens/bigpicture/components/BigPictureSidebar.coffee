_                = require 'lodash'
React            = require 'react'
Flux             = require 'mixins/Flux'
SidebarItemGroup = React.createFactory(require 'common/SidebarItemGroup')
TeamSidebarItem  = React.createFactory(require './TeamSidebarItem')
{div}            = React.DOM

BigPictureSidebar = React.createClass {

  displayName: 'BigPictureSidebar'

  mixins: [Flux('teams')]

  getStateFromStores: (stores) ->
    return {
      teams: stores.teams.getAllTeams()
    }

  componentWillMount: ->
    @getController().loadTeams()

  render: ->

    teams = _.map @state.teams, (team) =>
      TeamSidebarItem {key: "team-#{team.id}", team}

    div {className: 'bigpicture sidebar'}, [
      SidebarItemGroup {key: 'teams', header: 'Teams'}, teams
    ]

}

module.exports = BigPictureSidebar
