_           = require 'lodash'
React       = require 'react/addons'
PropTypes   = require 'common/PropTypes'
Observe     = require 'mixins/Observe'
CardContext = require '../CardContext'
Button      = React.createFactory(require 'common/Button')

RestoreCommandButton = React.createClass {

  displayName: 'RestoreCommandButton'

  mixins: [Observe()]

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
