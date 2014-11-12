_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
LoadAllTeamsRequest = require 'requests/LoadAllTeamsRequest'
SidebarItemGroup    = React.createFactory(require 'common/SidebarItemGroup')
TeamSidebarItem     = React.createFactory(require './TeamSidebarItem')
{div}               = React.DOM

BigPictureSidebar = React.createClass {

  displayName: 'BigPictureSidebar'

  mixins: [
    Observe('teams')
  ]

  getStateFromStores: (stores) ->
    return {
      teams: stores.teams.getAllTeams()
    }

  componentWillMount: ->
    @execute new LoadAllTeamsRequest()

  render: ->

    teams = _.map @state.teams, (team) =>
      TeamSidebarItem {key: "team-#{team.id}", team}

    div {className: 'bigpicture sidebar panel'}, [
      SidebarItemGroup {key: 'teams', header: 'Teams'}, teams
    ]

}

module.exports = BigPictureSidebar
