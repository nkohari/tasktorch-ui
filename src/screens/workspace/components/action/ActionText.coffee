React                   = require 'react'
PropTypes               = require 'common/PropTypes'
Observe                 = require 'mixins/Observe'
ChangeActionTextRequest = require 'requests/ChangeActionTextRequest'
Text                    = React.createFactory(require 'common/Text')

ActionText = React.createClass {

  displayName: 'ActionText'

  propTypes:
    action: PropTypes.Action

  mixins: [Observe()]

  render: ->
    Text {
      className:   'text'
      value:       @props.action.text
      save:        @setActionText
      placeholder: 'Action Text'
    }

  setActionText: (value) ->
    @execute new ChangeActionTextRequest(@props.action, value)

}

module.exports = ActionText
