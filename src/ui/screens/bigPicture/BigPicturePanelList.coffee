#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
SortableMixin       = require 'sortablejs/react-sortable-mixin'
UserMovedPanelEvent = require 'events/ui/UserMovedPanelEvent'
PropTypes           = require 'ui/framework/PropTypes'
Actor               = require 'ui/framework/mixins/Actor'
BigPicturePanel     = React.createFactory(require 'ui/screens/bigPicture/BigPicturePanel')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
{div}               = React.DOM
#--------------------------------------------------------------------------------

BigPicturePanelList = React.createClass {

  displayName: 'BigPicturePanelList'

  propTypes:
    panels: PropTypes.array

  mixins: [Actor, SortableMixin]

  sortableOptions:
    model:  'panels'
    handle: '.panel-header'

  getInitialState: ->
    {panels: @props.panels}

  render: ->

    panels = _.map _.compact(@state.panels), (spec) =>
      BigPicturePanel {key: spec.id, spec}

    CSSTransitionGroup {component: 'div', className: 'content', transitionName: 'slide'},
      panels

  handleUpdate: (event) ->
    panelid = event.item.getAttribute('data-id')
    @publish new UserMovedPanelEvent(panelid, event.newIndex)

}

module.exports = BigPicturePanelList
