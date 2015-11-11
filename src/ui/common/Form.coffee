#--------------------------------------------------------------------------------
_           = require 'lodash'
forms       = require 'newforms'
React       = require 'react'
mergeProps  = require 'common/util/mergeProps'
PropTypes   = require 'ui/framework/PropTypes'
Field       = React.createFactory(require 'ui/common/Field')
{form, div} = React.DOM
#--------------------------------------------------------------------------------

Form = React.createClass {

  displayName: 'Form'

  propTypes:
    form:    PropTypes.object
    note:    PropTypes.node
    buttons: PropTypes.node

  render: ->

    props = mergeProps _.omit(@props, 'form', 'buttons'), {
      className: 'form'
    }

    fields = _.map @props.form.boundFields(), (bf, index) =>
      Field {key: index, className: bf.field.cssClass, icon: bf.field.custom?.icon, label: bf.label, error: bf.errorMessage()},
        div {className: 'input'},
          bf.render()

    form props,
      div {className: 'form-content'},
        fields
        @props.note if @props.note?
      div {className: 'form-footer'},
        @props.buttons if @props.buttons?

}

module.exports = Form
