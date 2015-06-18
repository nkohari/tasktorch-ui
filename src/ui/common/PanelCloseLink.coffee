#--------------------------------------------------------------------------------
_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Navigator = require 'ui/framework/mixins/Navigator'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
#--------------------------------------------------------------------------------

PanelCloseLink = React.createClass {

  displayName: 'PanelCloseLink'

  propTypes:
    id: PropTypes.string

  mixins: [Navigator]

  render: ->
    Link {className: 'close', onClick: @closePanel},
      Icon {name: 'close'}

  closePanel: ->
    @getCurrentScreen().removePanel(@props.id)

}

module.exports = PanelCloseLink
