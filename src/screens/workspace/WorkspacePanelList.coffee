_                  = require 'lodash'
React              = require 'react/addons'
Router             = require 'react-router'
SortableList       = require 'mixins/SortableList'
WorkspaceUrl       = require 'framework/urls/WorkspaceUrl'
StackPanel         = React.createFactory(require './components/stack/StackPanel')
CardPanel          = React.createFactory(require './components/card/CardPanel')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

WorkspacePanelList = React.createClass {

  displayName: 'WorkspacePanelList'

  mixins: [
    Router.Navigation
    Router.State
    SortableList {
      handle: '.header'
      idAttribute: 'data-itemid'
    }
  ]

  render: ->

    url = new WorkspaceUrl(this)
    panels = _.map url.panels, (key) => @createPanel(key)

    CSSTransitionGroup {
      key: 'content'
      component: 'div'
      className: 'content'
      transitionName: 'slide'
    }, panels

  createPanel: (key) ->
    [type, id] = key.split(':')
    switch type
      when 's' then StackPanel {key: "stack-#{id}", stackid: id, 'data-itemid': "s:#{id}"}
      when 'c' then CardPanel  {key: "stack-#{id}", cardid: id, 'data-itemid': "c:#{id}"}
      else null

  getSortableList: ->
    # TODO: The SortableList mixin is designed to support connected lists, like StackCardList.
    # This hack allows us to use it for non-connected lists, but we should really fix the mixin.
    {id: 'dummy'}

  getSortableListItem: (id) ->
    {id}

  onReorder: (panel, toPosition) ->
    url = new WorkspaceUrl(this)
    url.movePanelToPosition(panel.id, toPosition)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

  onListOrderChanged: (ids) ->

}

module.exports = WorkspacePanelList
