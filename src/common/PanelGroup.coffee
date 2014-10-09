React = require 'react/addons'
{CSSTransitionGroup} = React.addons

PanelGroup = React.createClass {

  render: ->
    CSSTransitionGroup {transitionName: 'panel-slide'}, @props.children

}

module.exports = PanelGroup
