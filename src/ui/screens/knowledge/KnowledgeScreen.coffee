#--------------------------------------------------------------------------------
_     = require 'lodash'
React = require 'react'
Screen = React.createFactory(require 'ui/common/Screen')
#--------------------------------------------------------------------------------

KnowledgeScreen = React.createClass {

  displayName: 'KnowledgeScreen'

  render: ->

    Screen {className: 'knowledge'},
      "Not yet implemented"

}

module.exports = KnowledgeScreen
