_                = require 'lodash'
React            = require 'react/addons'
Icon             = React.createFactory(require 'common/Icon')
CardAction       = React.createFactory(require './CardAction')
{a, div, ul, li} = React.DOM
{classSet}       = React.addons

CardActionGroup = React.createClass {

  displayName: 'CardActionGroup'

  render: ->

    actions = _.map @props.actions, (action) =>
      CardAction {key: "action-#{action.id}", action}

    div {className: 'stage'}, [
      div {className: 'title'}, [@props.stage.name]
      ul {}, actions
    ]
  
}

module.exports = CardActionGroup
