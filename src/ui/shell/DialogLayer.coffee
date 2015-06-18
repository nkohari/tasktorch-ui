#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
DialogContainer = React.createFactory(require 'ui/common/DialogContainer')
{div}           = React.DOM
#--------------------------------------------------------------------------------

DIALOGS =
  ChangeMyName:     React.createFactory(require 'ui/dialogs/ChangeMyNameDialog')
  ChangeMyEmail:    React.createFactory(require 'ui/dialogs/ChangeMyEmailDialog')
  ChangeMyPassword: React.createFactory(require 'ui/dialogs/ChangeMyPasswordDialog')
  CreateGoal:       React.createFactory(require 'ui/dialogs/CreateGoalDialog')
  CreateKind:       React.createFactory(require 'ui/dialogs/CreateKindWizard')
  CreateStack:      React.createFactory(require 'ui/dialogs/CreateStackDialog')
  CreateTeam:       React.createFactory(require 'ui/dialogs/CreateTeamDialog')
  DeleteStack:      React.createFactory(require 'ui/dialogs/DeleteStackDialog')
  DeleteTeam:       React.createFactory(require 'ui/dialogs/DeleteTeamDialog')
  Help:             React.createFactory(require 'ui/dialogs/HelpDialog')
  RenameStack:      React.createFactory(require 'ui/dialogs/RenameStackDialog')
  RenameTeam:       React.createFactory(require 'ui/dialogs/RenameTeamDialog')
  TeamMembers:      React.createFactory(require 'ui/dialogs/TeamMembersDialog')
  UserSettings:     React.createFactory(require 'ui/dialogs/UserSettingsDialog')

DialogLayer = React.createClass {

  displayName: 'DialogLayer'

  render: ->

    items = _.map DIALOGS, (component, name) =>
      DialogContainer {key: name, name},
        component {name}

    div {className: 'dialog-layer'}, items

}

module.exports = DialogLayer
