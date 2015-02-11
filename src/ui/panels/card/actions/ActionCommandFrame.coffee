React                          = require 'react'
PropTypes                      = require 'framework/PropTypes'
Observe                        = require 'framework/mixins/Observe'
ActionCommand                  = require 'framework/enums/ActionCommand'
ChangeActionStatusCommandPanel = React.createFactory(require 'ui/panels/card/actions/commands/ChangeActionStatusCommandPanel')
ChangeActionOwnerCommandPanel  = React.createFactory(require 'ui/panels/card/actions/commands/ChangeActionOwnerCommandPanel')
DeleteActionCommandPanel       = React.createFactory(require 'ui/panels/card/actions/commands/DeleteActionCommandPanel')

ActionCommandFrame = React.createClass {

  displayName: 'ActionCommandFrame'

  propTypes:
    action:      PropTypes.Action
    command:     PropTypes.string
    showCommand: PropTypes.func
    hideCommand: PropTypes.func

  mixins: [Observe()]

  render: ->

    props =
      action:      @props.action
      hideCommand: @props.hideCommand

    switch @props.command
      when ActionCommand.ChangeStatus then ChangeActionStatusCommandPanel(props)
      when ActionCommand.ChangeOwner  then ChangeActionOwnerCommandPanel(props)
      when ActionCommand.Delete       then DeleteActionCommandPanel(props)

}

module.exports = ActionCommandFrame
