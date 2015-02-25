_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
UrlAware  = require 'ui/framework/mixins/UrlAware'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
{span}    = React.DOM

SpecialStackToggleButton = React.createClass {

  displayName: 'SpecialStackToggleButton'

  mixins: [UrlAware]

  propTypes:
    stack:  PropTypes.Stack
    icon:   PropTypes.string
    hotkey: PropTypes.string

  render: ->

    classes = classSet [
      'button'
      'active' if @getCurrentUrl().isPanelActive(PanelKey.forStack(@props.stack.id))
    ]

    Link {className: classes, hotkey: @props.hotkey, @getLinkUrl},
      Icon {name: "stack-#{@props.icon}"}
      span {className: 'count'}, @props.stack.cards.length

  getLinkUrl: (currentUrl) ->
    currentUrl.setScreen('workspace').togglePanel(PanelKey.forStack(@props.stack.id))

}

module.exports = SpecialStackToggleButton
