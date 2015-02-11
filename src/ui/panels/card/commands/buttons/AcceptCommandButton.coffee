_                 = require 'lodash'
React             = require 'react/addons'
PropTypes         = require 'framework/PropTypes'
Observe           = require 'framework/mixins/Observe'
AcceptCardRequest = require 'requests/AcceptCardRequest'
CardContext       = require 'ui/panels/card/CardContext'
Button            = React.createFactory(require 'ui/common/Button')
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
