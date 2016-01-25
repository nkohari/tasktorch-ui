#--------------------------------------------------------------------------------
React                 = require 'react'
KindStatus            = require 'data/enums/KindStatus'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
IdentityContext       = require 'ui/framework/mixins/IdentityContext'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogFooter          = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger         = React.createFactory(require 'ui/common/DialogTrigger')
OverlayTrigger        = React.createFactory(require 'ui/common/OverlayTrigger')
KindListItem          = React.createFactory(require 'ui/dialogs/manageKinds/KindListItem')
{ul, div}             = React.DOM
#--------------------------------------------------------------------------------
require './ManageKindsDialog.styl'
#--------------------------------------------------------------------------------

ManageKindsDialog = React.createClass {

  displayEmail: 'ManageKindsDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState, IdentityContext]

  getCachedState: (cache) -> {
    kinds: cache('kindsByOrg').get(@getCurrentOrg().id)
  }

  render: ->

    kinds = _.groupBy @state.kinds, (g) -> g.status

    footer = DialogFooter {
      left:  Button {text: 'Create new kind', onClick: @onCreateClicked}
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'kind', title: 'Manage Card Kinds', className: 'manage-kinds-dialog', width: 400, footer, closeDialog: @props.closeDialog},
      div {className: 'kind-list'},
        @renderKindGroup(kinds[KindStatus.Normal], "Active")
        @renderKindGroup(kinds[KindStatus.Archived], "Archived")

  renderKindGroup: (kinds, header) ->
    return unless kinds?
    items = _.map kinds, (kind) ->
      KindListItem {key: kind.id, kind}      
    return div {className: 'group'},
      div {className: 'group-header'},
        "#{header} (#{kinds.length})"
      ul {className: 'kind-group'}, items

  onCreateClicked: ->
    @publish new UserOpenedDialogEvent('CreateKind')

}

module.exports = ManageKindsDialog
