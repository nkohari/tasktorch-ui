_         = require 'lodash'
React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
Actor     = require 'ui/framework/mixins/Actor'
Button    = React.createFactory(require 'ui/common/Button')

RestoreCommandButton = React.createClass {

  displayName: 'RestoreCommandButton'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor]

  render: ->
    Button {
      icon:    'restore'
      text:    'Restore'
      onClick: @onButtonClicked
    }

  onButtonClicked: ->
    # TODO

}

module.exports = RestoreCommandButton
