#--------------------------------------------------------------------------------
React                 = require 'react'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
IdentityContext       = require 'ui/framework/mixins/IdentityContext'
Button                = React.createFactory(require 'ui/common/Button')
Icon                  = React.createFactory(require 'ui/common/Icon')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogFooter          = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger         = React.createFactory(require 'ui/common/DialogTrigger')
OverlayTrigger        = React.createFactory(require 'ui/common/OverlayTrigger')
KindContextMenu       = React.createFactory(require 'ui/overlays/KindContextMenu')
{ul, li, div}         = React.DOM
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

    items = _.map @state.kinds, (kind, index) =>
      li {key: kind.id, className: 'kind', onClick: @showKindMenu.bind(this, index)},
        div {className: 'kind-info'},
          div {className: 'kind-name'},
            Icon {name: 'card', color: kind.color}
            kind.name
          div {className: 'kind-description'},
            kind.description
        OverlayTrigger {ref: "trigger#{index}", overlay: KindContextMenu {kindid: kind.id}},
          Icon {name: 'trigger'}

    footer = DialogFooter {
      left:  Button {text: 'Create new kind', onClick: @onCreateClicked}
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'kind', title: 'Manage Card Kinds', className: 'manage-kinds-dialog', width: 400, footer, closeDialog: @props.closeDialog},
      ul {className: 'kind-list'},
        items

  showKindMenu: (index, event) ->
    event.stopPropagation()
    event.preventDefault()
    @refs["trigger#{index}"].showOverlay()

  onCreateClicked: ->
    @publish new UserOpenedDialogEvent('CreateKind')

}

module.exports = ManageKindsDialog
