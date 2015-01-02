_                 = require 'lodash'
React             = require 'react/addons'
PropTypes         = require 'common/PropTypes'
Observe           = require 'mixins/Observe'
AcceptCardRequest = require 'requests/AcceptCardRequest'
CardContext       = require '../CardContext'
Button            = React.createFactory(require 'common/Button')
{div}             = React.DOM

AcceptCommandButton = React.createClass {

  displayName: 'AcceptCommandButton'

  mixins: [CardContext, Observe()]

  render: ->
    Button {
      icon:    'accept'
      text:    'Accept'
      onClick: @onButtonClicked
    }

  onButtonClicked: ->
    @execute new AcceptCardRequest(@context.card)

}

module.exports = AcceptCommandButton
