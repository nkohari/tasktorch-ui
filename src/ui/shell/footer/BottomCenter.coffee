#--------------------------------------------------------------------------------
_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM
#--------------------------------------------------------------------------------
require './BottomCenter.styl'
#--------------------------------------------------------------------------------

BottomCenter = React.createClass {

  displayName: 'BottomCenter'

  render: ->

    div {className: 'bottom-center'},
      div {className: 'brand'},
        'TaskTorch'
        div {className: 'version'}, 'Private Beta'

}

module.exports = BottomCenter
