#--------------------------------------------------------------------------------
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CardFileList = React.createFactory(require 'ui/screens/workspace/panels/card/links/CardFileList')
{div}        = React.DOM
#--------------------------------------------------------------------------------

CardLinksTab = React.createClass {

  displayName: 'CardLinksTab'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: 'card-links-tab'},
      CardFileList {card: @props.card}

}

module.exports = CardLinksTab
