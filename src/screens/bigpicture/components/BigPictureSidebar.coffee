React        = require 'react'
Flux         = require 'mixins/Flux'
List         = React.createFactory(require 'common/List')
TeamListItem = React.createFactory(require './TeamListItem')
{div}        = React.DOM

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

    div {className: 'big-picture sidebar'}, [
      List {key: 'team-list', className: 'team-list', component: TeamListItem, kind: 'team', items: @state.teams}
    ]

}

module.exports = BigPictureSidebar
