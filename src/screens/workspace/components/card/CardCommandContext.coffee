_     = require 'lodash'
React = require 'react'

CardCommandContext = {

  contextTypes:
    activeCommand: React.PropTypes.string
    hideCommand:   React.PropTypes.func
    showCommand:   React.PropTypes.func

  childContextTypes:
    activeCommand: React.PropTypes.string
    hideCommand:   React.PropTypes.func.isRequired
    showCommand:   React.PropTypes.func.isRequired

  getChildContext: ->
    return {
      activeCommand: @state?.command ? @context?.activeCommand
      hideCommand:   @hideCommand    ? @context?.hideCommand
      showCommand:   @showCommand    ? @context?.showCommand
    }

}

module.exports = CardCommandContext
