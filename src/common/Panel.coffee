React       = require 'react/addons'
PanelHeader = require './PanelHeader'
{div}       = React.DOM

Panel = React.createClass {

  render: ->
    header = PanelHeader {panelTitle: @props.panelTitle, icon: @props.icon, close: @props.close}
    panel  = div {className: 'panel'}, [header].concat(@props.children)
    @transferPropsTo(panel)

}

module.exports = Panel
