_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

CardCloseLink = React.createClass {

  displayName: 'CardCloseLink'

  propTypes:
    card: PropTypes.Card

  render: ->
    Link {className: 'close', @getLinkUrl},
      Icon {name: 'close'}

  getLinkUrl: (currentUrl) ->
    currentUrl.removePanel(PanelKey.forCard(@props.card.id))

}

module.exports = CardCloseLink
