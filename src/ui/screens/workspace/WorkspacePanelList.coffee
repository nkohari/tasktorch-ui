_                  = require 'lodash'
dom                = require 'common/util/dom'
React              = require 'react/addons'
Navigator          = require 'ui/framework/mixins/Navigator'
SortableList       = require 'ui/framework/mixins/SortableList'
PropTypes          = require 'ui/framework/PropTypes'
WorkspacePanel     = React.createFactory(require 'ui/screens/workspace/WorkspacePanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

WorkspacePanelList = React.createClass {

  displayName: 'WorkspacePanelList'

  propTypes:
    panels:      PropTypes.array
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  mixins: [
    Navigator
    SortableList {
      handle: '.header, .card-header'
      idAttribute: 'data-itemid'
    }
  ]

  render: ->

    panels = _.map @props.panels, (panel) =>
      props = _.extend {key: panel.id, currentUser: @props.currentUser, currentOrg: @props.currentOrg}, panel
      WorkspacePanel(props)

    CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide', @onWheel},
      panels

  getSortableList: ->
    # TODO: The SortableList mixin is designed to support connected lists, like StackCardList.
    # This hack allows us to use it for non-connected lists, but we should really fix the mixin.
    {id: 'dummy'}

  getSortableListItem: (id) ->
    {id}

  onReorder: (panel, toPosition) ->
    # TODO

  onListOrderChanged: (ids) ->

  onWheel: (event) ->
    {deltaX, deltaY, target} = event
    ancestors = dom.getAncestors(target)
    if deltaX < 0 and not _.any(ancestors, (el) -> el.scrollLeft > 0)
      event.preventDefault()
    #if deltaY > 0 and not _.any(ancestors, (el) -> el.scrolTop > 0)
    #  event.preventDefault()

}

module.exports = WorkspacePanelList
