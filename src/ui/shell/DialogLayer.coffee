#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
DialogContainer = React.createFactory(require 'ui/common/DialogContainer')
{div}           = React.DOM
#--------------------------------------------------------------------------------

DIALOGS =
  CancelAccount:         React.createFactory(require 'ui/dialogs/CancelAccountDialog')
  ChangeKindWorkflow:    React.createFactory(require 'ui/dialogs/ChangeKindWorkflowDialog')
  ChangeMyName:          React.createFactory(require 'ui/dialogs/ChangeMyNameDialog')
  ChangeMyEmail:         React.createFactory(require 'ui/dialogs/ChangeMyEmailDialog')
  ChangeMyPassword:      React.createFactory(require 'ui/dialogs/ChangeMyPasswordDialog')
  ChangeGoalDescription: React.createFactory(require 'ui/dialogs/ChangeGoalDescriptionDialog')
  ChangeGoalStatus:      React.createFactory(require 'ui/dialogs/ChangeGoalStatusDialog')
  ChangeGoalTimeframe:   React.createFactory(require 'ui/dialogs/ChangeGoalTimeframeDialog')
  ChangeKindColor:       React.createFactory(require 'ui/dialogs/ChangeKindColorDialog')
  ChangeKindDescription: React.createFactory(require 'ui/dialogs/ChangeKindDescriptionDialog')
  ChangeKindStatus:      React.createFactory(require 'ui/dialogs/ChangeKindStatusDialog')
  ChangeOrgCreditCard:   React.createFactory(require 'ui/dialogs/ChangeOrgCreditCardDialog')
  ChangeOrgDiscount:     React.createFactory(require 'ui/dialogs/ChangeOrgDiscountDialog')
  ChangeOrgEmail:        React.createFactory(require 'ui/dialogs/ChangeOrgEmailDialog')
  CreateGoal:            React.createFactory(require 'ui/dialogs/CreateGoalDialog')
  CreateKind:            React.createFactory(require 'ui/dialogs/CreateKindWizard')
  CreateStack:           React.createFactory(require 'ui/dialogs/CreateStackDialog')
  CreateStage:           React.createFactory(require 'ui/dialogs/CreateStageDialog')
  CreateTeam:            React.createFactory(require 'ui/dialogs/CreateTeamDialog')
  DeleteGoal:            React.createFactory(require 'ui/dialogs/DeleteGoalDialog')
  DeleteStack:           React.createFactory(require 'ui/dialogs/DeleteStackDialog')
  DeleteStage:           React.createFactory(require 'ui/dialogs/DeleteStageDialog')
  DeleteTeam:            React.createFactory(require 'ui/dialogs/DeleteTeamDialog')
  FileLightbox:          React.createFactory(require 'ui/dialogs/FileLightboxDialog')
  GiveTokens:            React.createFactory(require 'ui/dialogs/GiveTokensDialog')
  Help:                  React.createFactory(require 'ui/dialogs/HelpDialog')
  ManageAccount:         React.createFactory(require 'ui/dialogs/ManageAccountDialog')
  ManageGoals:           React.createFactory(require 'ui/dialogs/ManageGoalsDialog')
  ManageKinds:           React.createFactory(require 'ui/dialogs/ManageKindsDialog')
  ManageTeams:           React.createFactory(require 'ui/dialogs/ManageTeamsDialog')
  OrgMembers:            React.createFactory(require 'ui/dialogs/OrgMembersDialog')
  ReactivateAccount:     React.createFactory(require 'ui/dialogs/ReactivateAccountDialog')
  RenameGoal:            React.createFactory(require 'ui/dialogs/RenameGoalDialog')
  RenameKind:            React.createFactory(require 'ui/dialogs/RenameKindDialog')
  RenameStack:           React.createFactory(require 'ui/dialogs/RenameStackDialog')
  RenameTeam:            React.createFactory(require 'ui/dialogs/RenameTeamDialog')
  SendInvites:           React.createFactory(require 'ui/dialogs/SendInvitesDialog')
  TeamMembers:           React.createFactory(require 'ui/dialogs/TeamMembersDialog')
  UserSettings:          React.createFactory(require 'ui/dialogs/UserSettingsDialog')

DialogLayer = React.createClass {

  displayName: 'DialogLayer'

  render: ->

    items = _.map DIALOGS, (component, name) =>
      DialogContainer {key: name, name},
        component {name}

    div {className: 'dialog-layer'}, items

}

module.exports = DialogLayer
