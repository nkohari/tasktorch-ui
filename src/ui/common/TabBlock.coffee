#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
classSet      = require 'common/util/classSet'
mergeProps    = require 'common/util/mergeProps'
PropTypes     = require 'ui/framework/PropTypes'
{div, li, ul} = React.DOM
#--------------------------------------------------------------------------------
require './TabBlock.styl'
#--------------------------------------------------------------------------------

TabBlock = React.createClass {

  displayName: 'TabBlock'

  propTypes:
    selected: PropTypes.string
    isReady:  PropTypes.func
    onChange: PropTypes.func

  getInitialState: ->
    {selected: @props.selected}

  componentWillMount: ->
    @tabs = _.flatten [@props.children]

  componentWillReceiveProps: (newProps) ->
    @tabs = _.flatten [newProps.children]
    if @props.selected isnt newProps.selected
      @setState {selected: newProps.selected}

  render: ->

    props = mergeProps _.omit(@props, 'selected'), {
      className: 'tab-block'
    }

    if not @props.isReady? or @props.isReady()
      content = _.find @tabs, (tab) => tab.key == @state.selected

    div props,
      ul {className: 'header'}, @renderHeaders()
      div {className: 'content'},
        content

  renderHeaders: ->
    _.map @tabs, (tab) =>
      classes = classSet [
        'tab'
        'active' if @state.selected == tab.key
      ]
      li {key: tab.key, className: classes, onClick: @selectTab.bind(this, tab.key)},
        tab.props.title

  selectTab: (key) ->
    @setState {selected: key}
    @props.onChange(key) if @props.onChange?

}

module.exports = TabBlock
