_           = require 'lodash'
React       = require 'react/addons'
PanelHeader = React.createFactory(require './PanelHeader')
{div}       = React.DOM

Panel = React.createClass {

  displayName: 'Panel'
  
  render: ->

    props = _.extend {}, @props

    classes = props.className ? ''
    classes = classes.split(' ').concat('panel').join(' ')
    props.className = classes

    header  = PanelHeader {key: 'panel-header', panelTitle: @props.panelTitle, icon: @props.icon, close: @props.close}
    panel   = div props, [header].concat(@props.children)

}

module.exports = Panel
