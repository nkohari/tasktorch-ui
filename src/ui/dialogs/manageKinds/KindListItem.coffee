#--------------------------------------------------------------------------------
React           = require 'react'
classSet        = require 'common/util/classSet'
PropTypes       = require 'ui/framework/PropTypes'
Icon            = React.createFactory(require 'ui/common/Icon')
OverlayTrigger  = React.createFactory(require 'ui/common/OverlayTrigger')
KindContextMenu = React.createFactory(require 'ui/overlays/KindContextMenu')
{li, div}       = React.DOM
#--------------------------------------------------------------------------------
require './KindListItem.styl'
#--------------------------------------------------------------------------------

KindListItem = React.createClass {

  displayEmail: 'KindListItem'

  propTypes:
    kind: PropTypes.Kind

  render: ->

    classes = classSet [
      'kind-list-item'
      @props.kind.status.toLowerCase()
    ]

    li {className: classes, onClick: @showContextMenu},
      div {className: 'kind-info'},
        div {className: 'kind-name'},
          Icon {name: 'card', color: @props.kind.color}
          @props.kind.name
        div {className: 'kind-description'},
          @props.kind.description
      OverlayTrigger {ref: 'trigger', overlay: KindContextMenu {kindid: @props.kind.id}},
        Icon {name: 'trigger'}

  showContextMenu: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @refs.trigger.showOverlay()

}

module.exports = KindListItem
