_             = require 'lodash'
React         = require 'react'
classSet      = require 'common/util/classSet'
KindTemplates = require 'data/KindTemplates'
PropTypes     = require 'ui/framework/PropTypes'
Icon          = React.createFactory(require 'ui/common/Icon')
{div, li, ul} = React.DOM

KindTemplateList = React.createClass {

  displayName: 'KindTemplateList'

  propTypes:
    disabled: PropTypes.bool
    value:    PropTypes.object
    onChange: PropTypes.func

  render: ->

    items = _.map KindTemplates, (template) =>
      console.log(template)
      classes = classSet [
        'kind-template'
        'selected' if @props.value is template
      ]
      li {key: template.id, className: classes, onClick: @props.onChange.bind(null, template)},
        Icon {name: 'card', color: template.color}
        div {className: 'template-info'},
          div {className: 'template-name'}, template.name
          div {className: 'template-description'}, template.description

    classes = classSet [
      'kind-template-list'
      'disabled' if @props.disabled
    ]

    ul {className: classes}, items

}

module.exports = KindTemplateList