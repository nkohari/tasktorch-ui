_           = require 'lodash'
React       = require 'react/addons'
PropTypes   = require 'framework/PropTypes'
Observe     = require 'framework/mixins/Observe'
CardContext = require 'ui/panels/card/CardContext'
Button      = React.createFactory(require 'ui/common/Button')

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
