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

  getInitialState: ->
    {selected: @props.selected}

  componentWillMount: ->
    @tabs = _.flatten [@props.children]

  componentWillReceiveProps: (newProps) ->
    @tabs = _.flatten [newProps.children]

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
      li {key: tab.key, className: classes, onClick: @onTabClicked.bind(this, tab.key)},
        tab.props.title

  onTabClicked: (key, event) ->
    @setState {selected: key}

}

module.exports = TabBlock
