#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
classSet      = require 'common/util/classSet'
KindTemplates = require 'config/KindTemplates'
KeyCode       = require 'ui/framework/KeyCode'
PropTypes     = require 'ui/framework/PropTypes'
Icon          = React.createFactory(require 'ui/common/Icon')
{div, li, ul} = React.DOM
#--------------------------------------------------------------------------------
require './KindTemplateList.styl'
#--------------------------------------------------------------------------------

KindTemplateList = React.createClass {

  displayName: 'KindTemplateList'

  propTypes:
    disabled: PropTypes.bool
    value:    PropTypes.object
    onChange: PropTypes.func

  componentWillMount: ->
    @values = KindTemplates

  render: ->

    items = _.map @values, (template, index) =>
      classes = classSet [
        'kind-template'
        'selected' if @props.value is template
      ]
      li {key: template.id, ref: "item#{index}", tabIndex: index, className: classes, @onKeyUp, onFocus: @props.onChange.bind(null, template)},
        Icon {name: 'card', color: template.color}
        div {className: 'template-info'},
          div {className: 'template-name'}, template.name
          div {className: 'template-description'}, template.description

    classes = classSet [
      'kind-template-list'
      'disabled' if @props.disabled
    ]

    ul {className: classes}, items

  onKeyUp: (event) ->

    if @props.value?
      currentIndex = _.findIndex @values, (template) => template.id == @props.value.id
    else
      currentIndex = -1

    if event.which == KeyCode.UP and currentIndex > 0
      @refs["item#{currentIndex - 1}"].getDOMNode().focus()

    if event.which == KeyCode.DOWN and currentIndex < @values.length - 1
      @refs["item#{currentIndex + 1}"].getDOMNode().focus()

}

module.exports = KindTemplateList