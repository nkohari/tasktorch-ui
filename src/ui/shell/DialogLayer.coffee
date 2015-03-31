_               = require 'lodash'
React           = require 'react/addons'
PropTypes       = require 'ui/framework/PropTypes'
DialogContainer = React.createFactory(require 'ui/common/DialogContainer')
{div}           = React.DOM

DIALOGS =
  LogOut:       React.createFactory(require 'ui/dialogs/LogOutDialog')
  CreateStack:  React.createFactory(require 'ui/dialogs/CreateStackDialog')
  CreateTeam:   React.createFactory(require 'ui/dialogs/CreateTeamDialog')
  DeleteTeam:   React.createFactory(require 'ui/dialogs/DeleteTeamDialog')
  RenameTeam:   React.createFactory(require 'ui/dialogs/RenameTeamDialog')
  TeamMembers:  React.createFactory(require 'ui/dialogs/TeamMembersDialog')
  UserSettings: React.createFactory(require 'ui/dialogs/UserSettingsDialog')

DialogLayer = React.createClass {

  displayName: 'DialogLayer'

  render: ->

    items = _.map DIALOGS, (component, name) =>
      DialogContainer {key: name, name},
        component {name}

    div {className: 'dialog-layer'}, items

}

module.exports = DialogLayer
