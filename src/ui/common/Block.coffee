_          = require 'lodash'
React      = require 'react/addons'
PropTypes  = require 'ui/framework/PropTypes'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
{div}      = React.DOM

Block = React.createClass {

  displayName: 'Block'

  propTypes:
    collapsible: PropTypes.bool
    expanded:    PropTypes.bool
    title:       PropTypes.string
    isReady:     PropTypes.func

  getDefaultProps: ->
    {collapsible: false, expanded: true}

  getInitialState: ->
    {expanded: @props.expanded}

  shouldShowContents: ->
    return false if @props.isReady? and not @props.isReady()
    return false if @props.collapsible and not @state.expanded
    return true

  render: ->

    classes = classSet [
      'block'
      'collapsible' if @props.collapsible
      'expanded'    if @props.collapsible and @state.expanded
      'collapsed'   if @props.collapsible and !@state.expanded
    ]

    props = mergeProps _.omit(@props, 'title'), {
      className: classes
    }

    if @shouldShowContents()
      contents = div {className: 'contents'}, @props.children

    div props,
      div {className: 'header', onClick: @onHeaderClicked}, @props.title
      contents

  onHeaderClicked: ->
    return unless @props.collapsible
    @setState {expanded: !@state.expanded}
}

module.exports = Block
