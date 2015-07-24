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

  render: ->

    props = mergeProps _.omit(@props, 'selected'), {
      className: 'tab-block'
    }

    if not @props.isReady? or @props.isReady()
      content = _.find @props.children, (child) => child.key == @state.selected

    div props,
      ul {className: 'header'}, @renderHeaders()
      div {className: 'content'},
        content

  renderHeaders: ->
    _.map @props.children, (child) =>
      classes = classSet [
        'tab'
        'active' if @state.selected == child.key
      ]
      li {key: child.key, className: classes, onClick: @onTabClicked.bind(this, child.key)},
        child.props.title

  onTabClicked: (key, event) ->
    @setState {selected: key}

}

module.exports = TabBlock
