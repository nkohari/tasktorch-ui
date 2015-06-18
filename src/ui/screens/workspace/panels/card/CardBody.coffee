#--------------------------------------------------------------------------------
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
TabBlock          = React.createFactory(require 'ui/common/TabBlock')
CardDetailsTab    = React.createFactory(require 'ui/screens/workspace/panels/card/CardDetailsTab')
CardActionsTab    = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionsTab')
CardTimelineTab   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CardTimelineTab')
{div}             = React.DOM
#--------------------------------------------------------------------------------
require './CardBody.styl'
#--------------------------------------------------------------------------------

CardBody = React.createClass {

  displayName: 'CardBody'

  propTypes:
    card: PropTypes.Card
    kind: PropTypes.Kind

  render: ->

    TabBlock {className: 'card-body', selected: 'actions'},
      CardActionsTab  {key: 'actions',  title: 'Actions',  card: @props.card, kind: @props.kind}
      CardDetailsTab  {key: 'details',  title: 'Details',  card: @props.card}
      CardTimelineTab {key: 'timeline', title: 'Timeline', card: @props.card}

}

module.exports = CardBody
