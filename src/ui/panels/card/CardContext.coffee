_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'

CardContext = {

  contextTypes:
    card:             PropTypes.Card
    activeCommand:    PropTypes.string
    showCommandPanel: PropTypes.func
    hideCommandPanel: PropTypes.func

  childContextTypes:
    card:             PropTypes.Card
    activeCommand:    PropTypes.string
    showCommandPanel: PropTypes.func
    hideCommandPanel: PropTypes.func

  isActiveCommand: (command) ->
    @context? and @context.activeCommand == command

  getChildContext: ->
    return {
      card:             @state?.card      ? @context?.card
      activeCommand:    @state?.command   ? @context?.activeCommand
      showCommandPanel: @showCommandPanel ? @context?.showCommandPanel
      hideCommandPanel: @hideCommandPanel ? @context?.hideCommandPanel
    }

}

module.exports = CardContext
