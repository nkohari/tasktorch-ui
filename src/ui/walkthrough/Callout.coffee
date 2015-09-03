#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
mergeClasses = require 'common/util/mergeClasses'
{div}        = React.DOM
#--------------------------------------------------------------------------------
require './Callout.styl'
#--------------------------------------------------------------------------------

UPDATE_FREQUENCY_MS = 100
OFFSET_PIXELS = 10

Callout = React.createClass {

  displayName: 'Callout'

  propTypes:
    selector:  PropTypes.string
    position:  PropTypes.string
    forceSize: PropTypes.bool

  getDefaultProps: ->
    {position: 'bottom left', forceSize: true}

  componentDidMount: ->
    check = () =>
      @forceUpdate() if @hasElementChanged()
      @timeout = setTimeout(check, UPDATE_FREQUENCY_MS)
    @timeout = setTimeout(check, UPDATE_FREQUENCY_MS)

  componentWillUnmount: ->
    clearTimeout(@timeout) if @timeout?

  render: ->

    classes = mergeClasses(@props.className, 'callout')

    element = @getElement()
    unless element?
      return div {className: classes}

    div {className: classes, onClick: @props.advance},
      @renderClone(element)
      div {className: 'callout-caption', style: @getPosition(element)},
        @props.children

  renderClone: (element) ->

    pos = element.getBoundingClientRect()

    style =
      left:   pos.left
      top:    pos.top
      width:  pos.width  if @props.forceSize
      height: pos.height if @props.forceSize

    content = {__html: element.outerHTML}
    div {className: 'callout-content', style, dangerouslySetInnerHTML: content}

  getPosition: (element) ->

    screen = document.body.getBoundingClientRect()
    pos    = element.getBoundingClientRect()

    switch @props.position
      when 'above left'
        {bottom: screen.height - pos.top + OFFSET_PIXELS, left: pos.left}
      when 'above right'
        {bottom: screen.height - pos.top + OFFSET_PIXELS, right: screen.width - pos.right}
      when 'below left'
        {top: pos.bottom + OFFSET_PIXELS, left: pos.left}
      when 'below right'
        {top: pos.bottom + OFFSET_PIXELS, right: screen.width - pos.right}
      when 'top left'
        {top: pos.top, right: screen.width - (pos.left - OFFSET_PIXELS)}
      when 'middle left'
        {top: (pos.top + pos.bottom) / 2, right: screen.width - (pos.left - OFFSET_PIXELS)}
      when 'bottom left'
        {bottom: screen.height - pos.bottom, right: screen.width - (pos.left - OFFSET_PIXELS)}
      when 'top right'
        {top: pos.top, left: pos.right + OFFSET_PIXELS}
      when 'middle right'
        {top: (pos.top + pos.bottom) / 2, left: pos.right + OFFSET_PIXELS}
      when 'bottom right'
        {bottom: screen.height - pos.bottom, left: pos.right + OFFSET_PIXELS}

  getElement: ->
    document.querySelector(@props.selector)

  hasElementChanged: ->
    subject = @getElement()
    return subject? and @last != subject.outerHTML

}

module.exports = Callout
