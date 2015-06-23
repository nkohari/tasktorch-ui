#--------------------------------------------------------------------------------
React          = require 'react'
classSet       = require 'common/util/classSet'
mergeClasses   = require 'common/util/mergeClasses'
Hints          = require 'config/Hints'
PropTypes      = require 'ui/framework/PropTypes'
Icon           = React.createFactory(require 'ui/common/Icon')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')
Overlay        = React.createFactory(require 'ui/common/Overlay')
{div, label}   = React.DOM
#--------------------------------------------------------------------------------
require './Field.styl'
#--------------------------------------------------------------------------------

Field = React.createClass {

  displayName: 'Field'

  props:
    icon:         PropTypes.string
    label:        PropTypes.node
    hint:         PropTypes.node
    hintPosition: PropTypes.string
    error:        PropTypes.string
    expand:       PropTypes.bool

  getDefaultProps: ->
    {expand: false, hintPosition: 'after'}

  render: ->

    classes = mergeClasses(classSet [
      'field'
      'error'  if @props.error?
      'valid'  if @props.valid
      'expand' if @props.expand
    ], @props.className)

    if @props.error?
      overlay = Overlay {position: 'top right'}, @props.error
      status = OverlayTrigger {method: 'hover', className: 'field-status', overlay},
        Icon {name: 'error'}

    if @props.valid?
      status = Icon {name: 'success'}

    div {className: classes},
      div {className: 'field-meta'},
        Icon {name: @props.icon, className: 'field-icon'} if @props.icon?
        label {className: 'field-label'}, @props.label
        status
      div {className: 'hint'},        Hints[@props.hint] if @props.hint? and @props.hintPosition is 'before'
      div {className: 'field-input'}, @props.children
      div {className: 'hint'},        Hints[@props.hint] if @props.hint? and @props.hintPosition is 'after'

}

module.exports = Field
