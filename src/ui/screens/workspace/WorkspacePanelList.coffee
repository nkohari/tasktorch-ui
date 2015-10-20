#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
SortableMixin       = require 'sortablejs/react-sortable-mixin'
dom                 = require 'common/util/dom'
UserMovedPanelEvent = require 'events/ui/UserMovedPanelEvent'
PropTypes           = require 'ui/framework/PropTypes'
Actor               = require 'ui/framework/mixins/Actor'
WorkspacePanel      = React.createFactory(require 'ui/screens/workspace/WorkspacePanel')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------

WorkspacePanelList = React.createClass {

  displayName: 'WorkspacePanelList'

  mixins: [Actor, SortableMixin]

  propTypes:
    panels: PropTypes.array

  sortableOptions:
    model:  'panels'
    handle: '.panel-header'

  getInitialState: ->
    {panels: @props.panels}

  componentWillReceiveProps: (newProps) ->
    @setState {panels: newProps.panels}

  render: ->

    panels = _.map _.compact(@state.panels), (spec) =>
      WorkspacePanel {key: spec.id, spec}

    CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide', @onWheel},
      panels

  handleUpdate: (event) ->
    panelid = event.item.getAttribute('data-id')
    @publish new UserMovedPanelEvent(panelid, event.newIndex)

  onWheel: (event) ->
    {deltaX, deltaY, target} = event
    ancestors = dom.getAncestors(target)
    if deltaX < 0 and not _.any(ancestors, (el) -> el.scrollLeft > 0)
      event.preventDefault()
    #if deltaY > 0 and not _.any(ancestors, (el) -> el.scrolTop > 0)
    #  event.preventDefault()

}

module.exports = WorkspacePanelList
