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

  sync: (stores) ->
    return {
      teams: stores.teams.getAll()
    }

  componentWillMount: ->
    @execute new LoadAllTeamsRequest()

  render: ->

    teams = _.map @state.teams, (team) =>
      TeamSidebarItem {key: "team-#{team.id}", team}

    div {className: 'bigpicture sidebar'}, [
      SidebarItemGroup {key: 'teams', header: 'Teams'}, teams
    ]

}

module.exports = BigPictureSidebar
