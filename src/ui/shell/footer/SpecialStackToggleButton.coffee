_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
Url       = require 'framework/Url'
PropTypes = require 'framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
{span}    = React.DOM

SpecialStackToggleButton = React.createClass {

  displayName: 'SpecialStackToggleButton'

  mixins: [Router.State]

  propTypes:
    stack:  PropTypes.Stack
    icon:   PropTypes.string
    hotkey: PropTypes.string

  render: ->

    url = new Url(this)

    classes = ['button']
    classes.push('active') if url.isStackActive(@props.stack.id)

    url.screen = 'workspace'
    url.toggleStack(@props.stack.id)

    props = url.makeLinkProps {
      className: classes.join(' ')
      hotkey:    @props.hotkey
    }

    Link props,
      Icon {name: "stack-#{@props.icon}"}
      span {className: 'count'}, @props.stack.cards.length

}

module.exports = SpecialStackToggleButton
