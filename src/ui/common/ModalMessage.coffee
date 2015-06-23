#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
{div, img, span} = React.DOM
#--------------------------------------------------------------------------------
require './ModalMessage.styl'
#--------------------------------------------------------------------------------

ModalMessage = React.createClass {

  displayName: 'ModalMessage'

  render: ->

    div {className: 'modal-message'},
      @props.children

}

module.exports = ModalMessage
