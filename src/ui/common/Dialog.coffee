React      = require 'react'
PropTypes  = require 'framework/PropTypes'
mergeProps = require 'framework/util/mergeProps'
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

  render: ->

    props = mergeProps @props, {
      className: 'dialog-content'
    }

    if @props.title?
      header = div {className: 'dialog-header'},
        Icon {name: @props.icon} if @props.icon?
        @props.title

    div {className: 'dialog-container'},
      div {className: 'dialog-shadow', onClick: @props.close}
      div {className: 'dialog', style: {width: @props.width}},
        header
        div props, @props.children

}

module.exports = Dialog
