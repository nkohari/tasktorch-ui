_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'framework/PropTypes'
mergeProps    = require 'framework/util/mergeProps'
{div, li, ul} = React.DOM

TabBlock = React.createClass {

  displayName: 'TabBlock'

  propTypes:
    selected: PropTypes.string
    isReady:  PropTypes.func

  getInitialState: ->
    {selected: @props.selected}

  render: ->

    props = mergeProps _.omit(@props, 'selected'), {
      className: 'tab-block'
    }

    if not @props.isReady? or @props.isReady()
      selectedPanel = _.find @props.children, (child) => child.key == @state.selected

    div props,
      ul {className: 'header'}, @renderHeaders()
      div {className: 'content'}, selectedPanel

  renderHeaders: ->
    _.map @props.children, (child) =>
      classes = ['tab']
      classes.push('active') if @state.selected == child.key
      li {key: child.key, className: classes.join(' '), onClick: @onTabClicked.bind(this, child.key)},
        child.props.title

  onTabClicked: (key, event) ->
    @setState {selected: key}

}

module.exports = TabBlock
