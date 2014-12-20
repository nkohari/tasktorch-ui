_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
PropTypes    = require 'common/PropTypes'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
StackName    = React.createFactory(require 'common/StackName')
Link         = React.createFactory(Router.Link)
{li}         = React.DOM

CardLocation = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardLocation'

  propTypes:
    stack: PropTypes.Stack.isRequired

  mixins: [ActiveUrl(WorkspaceUrl)]

  # Rendering ---------------------------------------------------------------------

  render: ->
    li {className: 'location'}, [
      Link @makeStackLinkProps(), [
        Icon      {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
        StackName {key: 'name', stack: @props.stack}
      ]
    ]

  # Utility -----------------------------------------------------------------------

  makeStackLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stack.id)
    return _.extend {key: 'link'}, url.makeLinkProps()

  #--------------------------------------------------------------------------------

}

module.exports = CardLocation
