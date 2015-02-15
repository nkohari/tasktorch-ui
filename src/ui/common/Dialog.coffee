React      = require 'react'
mergeProps = require 'framework/util/mergeProps'
{div}      = React.DOM

Dialog = React.createClass {

  displayName: 'Dialog'

  render: ->

    props = mergeProps @props, {
      className: 'dialog'
    }

    div {className: 'dialog-container'},
      div props, @props.children

}

module.exports = Dialog
