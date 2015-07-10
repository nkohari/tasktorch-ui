#--------------------------------------------------------------------------------
_                  = require 'lodash'
dom                = require 'common/util/dom'
React              = require 'react'
Navigator          = require 'ui/framework/mixins/Navigator'
PropTypes          = require 'ui/framework/PropTypes'
WorkspacePanel     = React.createFactory(require 'ui/screens/workspace/WorkspacePanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------

WorkspacePanelList = React.createClass {

  displayName: 'WorkspacePanelList'

  propTypes:
    panels: PropTypes.array

  mixins: [Navigator]

  render: ->

    panels = _.map @props.panels, (panelProps) =>
      props = _.extend {key: panelProps.id}, panelProps
      WorkspacePanel(props)

    CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide', @onWheel},
      panels

  onWheel: (event) ->
    {deltaX, deltaY, target} = event
    ancestors = dom.getAncestors(target)
    if deltaX < 0 and not _.any(ancestors, (el) -> el.scrollLeft > 0)
      event.preventDefault()
    #if deltaY > 0 and not _.any(ancestors, (el) -> el.scrolTop > 0)
    #  event.preventDefault()

}

module.exports = WorkspacePanelList
