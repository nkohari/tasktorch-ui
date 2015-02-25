_                  = require 'lodash'
dom                = require 'common/util/dom'
React              = require 'react/addons'
Router             = require 'react-router'
SortableList       = require 'ui/framework/mixins/SortableList'
UrlAware           = require 'ui/framework/mixins/UrlAware'
PanelKey           = require 'ui/framework/PanelKey'
PropTypes          = require 'ui/framework/PropTypes'
UrlModel           = require 'ui/framework/UrlModel'
StackPanel         = React.createFactory(require 'ui/panels/stack/StackPanel')
CardPanel          = React.createFactory(require 'ui/panels/card/CardPanel')
FollowingPanel     = React.createFactory(require 'ui/panels/following/FollowingPanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

WorkspacePanelList = React.createClass {

  displayName: 'WorkspacePanelList'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  contextTypes:
    currentUrl: PropTypes.object

  mixins: [
    Router.Navigation
    SortableList {
      handle: '.header'
      idAttribute: 'data-itemid'
    }
    UrlAware
  ]

  render: ->
    panels = _.map @getCurrentUrl().getPanels(), (key) => @createPanel(key)
    CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide', @onWheel},
      panels

  createPanel: (key) ->
    panel = PanelKey.parse(key)
    switch panel.type
      when 'stack'     then StackPanel     {key, "data-itemid": key, currentUser: @props.currentUser, stackid: panel.id}
      when 'card'      then CardPanel      {key, "data-itemid": key, currentUser: @props.currentUser, cardid: panel.id}
      when 'following' then FollowingPanel {key, "data-itemid": key, currentUser: @props.currentUser}
      else null

  getSortableList: ->
    # TODO: The SortableList mixin is designed to support connected lists, like StackCardList.
    # This hack allows us to use it for non-connected lists, but we should really fix the mixin.
    {id: 'dummy'}

  getSortableListItem: (id) ->
    {id}

  onReorder: (panel, toPosition) ->
    url = @getCurrentUrl().movePanelToPosition(panel.id, toPosition)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

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
