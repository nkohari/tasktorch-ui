_                = require 'lodash'
React            = require 'react/addons'
PropTypes        = require 'framework/PropTypes'
mergeProps       = require 'framework/util/mergeProps'
{div}            = React.DOM
{cloneWithProps} = React.addons

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

    classes = ['block']
    classes.push('collapsible') if @props.collapsible
    classes.push('expanded')    if @props.collapsible and @state.expanded

    props = mergeProps _.omit(@props, 'title'), {
      className: classes.join(' ')
    }

    if @shouldShowContents()
      contents = div {className: 'contents'}, @props.children

    div props,
      div {className: 'header', onClick: @onHeaderClicked}, @props.title
      contents

  onHeaderClicked: ->
    return unless @props.collapsible
    @setState {expanded: !@state.expanded}, =>
      @forceUpdate() if @state.expanded

}

module.exports = Block
