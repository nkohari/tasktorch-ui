#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
UserClosedPanelEvent = require 'events/ui/UserClosedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Icon                 = React.createFactory(require 'ui/common/Icon')
Link                 = React.createFactory(require 'ui/common/Link')
#--------------------------------------------------------------------------------

PanelCloseLink = React.createClass {

  displayName: 'PanelCloseLink'

  propTypes:
    id: PropTypes.string

  mixins: [Actor]

  render: ->
    Link {className: 'close', onClick: @closePanel},
      Icon {name: 'close'}

  closePanel: ->
    @publish new UserClosedPanelEvent(@props.id)

}

module.exports = PanelCloseLink
