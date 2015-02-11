React                   = require 'react'
PropTypes               = require 'framework/PropTypes'
Observe                 = require 'framework/mixins/Observe'
ChangeActionTextRequest = require 'requests/ChangeActionTextRequest'
EditableText            = React.createFactory(require 'ui/common/EditableText')

ActionText = React.createClass {

  displayName: 'ActionText'

  propTypes:
    action: PropTypes.Action

  mixins: [Observe()]

  render: ->
    EditableText {
      className:   'text'
      value:       @props.action.text
      save:        @setActionText
      placeholder: 'Action Text'
    }

  setActionText: (value) ->
    @execute new ChangeActionTextRequest(@props.action, value)

}

module.exports = ActionText
