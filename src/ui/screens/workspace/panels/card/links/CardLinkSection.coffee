#--------------------------------------------------------------------------------
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Icon        = React.createFactory(require 'ui/common/Icon')
{div, span} = React.DOM
#--------------------------------------------------------------------------------
require './CardLinkSection.styl'
#--------------------------------------------------------------------------------

CardLinkSection = React.createClass {

  displayName: 'CardLinkSection'

  propTypes:
    card:     PropTypes.Card
    icon:     PropTypes.string
    title:    PropTypes.string
    count:    PropTypes.number
    controls: PropTypes.node

  getDefaultProps: ->
    {count: 0}

  render: ->

    if @props.controls?
      controls = span {className: 'controls'},
        @props.controls

    div {className: 'card-link-section'},
      div {className: 'header'},
        Icon {name: @props.icon}
        span {className: 'title'},
          @props.title
          span {className: 'count'},
            "(#{@props.count})"
        controls
      @props.children

}

module.exports = CardLinkSection
