React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
mergeProps = require 'common/util/mergeProps'
Icon       = React.createFactory(require 'ui/common/Icon')
{div}      = React.DOM

Dialog = React.createClass {

  displayName: 'Dialog'

  propTypes:
    close: PropTypes.func
    icon:  PropTypes.string
    title: PropTypes.string
    width: PropTypes.number

  getDefaultProps: ->
    {width: 600}

  componentDidMount: ->
    node = @refs.dialog.getDOMNode()
    node.style.marginTop = "#{@getMarginAdjustment()}px"

  render: ->

    props = mergeProps @props, {
      className: 'dialog-content'
    }

    if @props.title?
      header = div {className: 'dialog-header'},
        Icon {name: @props.icon} if @props.icon?
        @props.title

    style = {width: @props.width}
    style.marginTop = @getMarginAdjustment() if @isMounted()

    div {className: 'dialog-container'},
      div {className: 'dialog-shadow', onClick: @props.close}
      div {ref: 'dialog', className: 'dialog', style},
        header
        div props, @props.children

  getMarginAdjustment: ->
    node = @refs.dialog.getDOMNode()
    return -(node.clientHeight / 2)

}

module.exports = Dialog
