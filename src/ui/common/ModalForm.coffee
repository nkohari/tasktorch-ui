#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Form       = React.createFactory(require 'ui/common/Form')
#--------------------------------------------------------------------------------
require './ModalForm.styl'
#--------------------------------------------------------------------------------

ModalForm = React.createClass {

  displayName: 'ModalForm'

  render: ->

    props = mergeProps @props, {
      className: 'modal-form'
    }

    Form props,
      @props.note    if @props.note?
      @props.buttons if @props.buttons?

}

module.exports = ModalForm
