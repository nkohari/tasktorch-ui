_                     = require 'lodash'
React                 = require 'react/addons'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
UserAcceptedCardEvent = require 'events/ui/UserAcceptedCardEvent'
Button                = React.createFactory(require 'ui/common/Button')
{div}                 = React.DOM

AcceptCommandButton = React.createClass {

  displayName: 'AcceptCommandButton'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor]

  render: ->
    
    Button {
      icon:    'accept'
      text:    'Accept'
      onClick: @onButtonClicked
    }

  onButtonClicked: ->
    @publish new UserAcceptedCardEvent(@props.card.id)

}

module.exports = AcceptCommandButton
