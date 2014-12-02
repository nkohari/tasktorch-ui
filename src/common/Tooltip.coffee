React      = require 'react/addons'
{div}      = React.DOM
{classSet} = React.addons

Tooltip = React.createClass {

  displayName: 'Tooltip'

  render: ->

    classes = {tooltip: true}
    classes[@props.placement] = true

    div {
      className: classSet(classes)
      style: {left: @props.position.left, top: @props.position.top}
    }, [
      div {key: 'arrow', className: 'arrow'}
      div {key: 'text',  className: 'text'}, [@props.text]
    ]

}

module.exports = Tooltip
