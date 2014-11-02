React = require 'react/addons'
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

PanelGroup = React.createClass {

  displayName: 'PanelGroup'

  render: ->
    CSSTransitionGroup {
      component: 'div'
      className: 'panel-group'
      transitionName: 'panel-slide'
    }, @props.children

}

module.exports = PanelGroup
