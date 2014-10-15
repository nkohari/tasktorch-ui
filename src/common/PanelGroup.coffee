React = require 'react/addons'
{div} = React.DOM
{CSSTransitionGroup} = React.addons

PanelGroup = React.createClass {

  render: ->
    CSSTransitionGroup {component: div, className: 'panel-group', transitionName: 'panel-slide'}, @props.children

}

module.exports = PanelGroup
