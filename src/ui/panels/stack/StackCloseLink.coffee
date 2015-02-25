_         = require 'lodash'
React     = require 'react'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

StackCloseLink = React.createClass {

  displayName: 'StackCloseLink'

  propTypes:
    stack: PropTypes.Stack

  render: ->
    Link {className: 'close', @getLinkUrl},
      Icon {name: 'close'}

  getLinkUrl: (currentUrl) ->
    currentUrl.removePanel(PanelKey.forStack(@props.stack.id))

}

module.exports = StackCloseLink
