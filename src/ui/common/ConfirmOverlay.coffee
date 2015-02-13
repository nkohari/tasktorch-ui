React      = require 'react'
PropTypes  = require 'framework/PropTypes'
mergeProps = require 'framework/util/mergeProps'
Button     = React.createFactory(require 'ui/common/Button')
{div}      = React.DOM

ConfirmOverlay = React.createClass {

  displayName: 'ConfirmOverlay'

  propTypes:
    confirm:          PropTypes.string
    cancel:           PropTypes.string
    hide:             PropTypes.func
    onConfirmClicked: PropTypes.func
    onCancelClicked:  PropTypes.func

  render: ->

    props = mergeProps @props, {
      className: "overlay #{@props.placement}"
      style:     {left: @props.position.left, top: @props.position.top}
    }

    div props,
      div {className: 'arrow'}
      div {className: 'content'},
        div {className: 'text'},
          @props.prompt ? 'Are you sure?'
        div {className: 'buttons'},
          Button {className: 'small', text: @props.confirm ? 'OK',     onClick: @onConfirmClicked}
          Button {className: 'small', text: @props.cancel  ? 'Cancel', onClick: @onCancelClicked}

  onConfirmClicked: ->
    @props.onConfirmClicked()
    @props.hide()

  onCancelClicked: ->
    @props.onCancelClicked() if @props.onCancelClicked?
    @props.hide()

}

module.exports = ConfirmOverlay
