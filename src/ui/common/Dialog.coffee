#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
mergeClasses       = require 'common/util/mergeClasses'
mergeProps         = require 'common/util/mergeProps'
Icon               = React.createFactory(require 'ui/common/Icon')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
#--------------------------------------------------------------------------------
require './Dialog.styl'
#--------------------------------------------------------------------------------

Dialog = React.createClass {

  displayName: 'Dialog'

  propTypes:
    footer:      PropTypes.node
    closeDialog: PropTypes.func
    icon:        PropTypes.string
    title:       PropTypes.string
    width:       PropTypes.oneOfType(PropTypes.number, PropTypes.string)
    height:      PropTypes.oneOfType(PropTypes.number, PropTypes.string)
    maxWidth:    PropTypes.oneOfType(PropTypes.number, PropTypes.string)
    maxHeight:   PropTypes.oneOfType(PropTypes.number, PropTypes.string)

  getDefaultProps: ->
    {width: 600}

  render: ->

    props = mergeProps _.omit(@props, 'className', 'icon', 'title', 'height', 'width'), {
      className: 'dialog-content'
    }

    if @props.title?
      header = div {className: 'dialog-header'},
        Icon {name: @props.icon} if @props.icon?
        @props.title

    classes = mergeClasses('dialog', @props.className)

    style =
      width:     @props.width
      height:    @props.height    if @props.height?
      maxWidth:  @props.maxWidth  if @props.maxWidth?
      maxHeight: @props.maxHeight if @props.maxHeight?

    div {className: 'dialog-backdrop', onClick: @onBackdropClicked},
      div {ref: 'dialog', className: classes, style},
        header
        div props, @props.children
        @props.footer

  onBackdropClicked: (event) ->
    if event.target == @getDOMNode()
      @props.closeDialog()

}

module.exports = Dialog
