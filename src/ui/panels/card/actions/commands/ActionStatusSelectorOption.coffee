React     = require 'react'
PropTypes = require 'framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

ActionStatusSelectorOption = React.createClass {

  displayName: 'ActionStatusSelectorOption'

  propTypes:
    icon:   PropTypes.string
    text:   PropTypes.string
    value:  PropTypes.any

  render: ->
    div {}, [
      Icon {key: 'icon', name: @props.icon}
      @props.text
    ]

}

module.exports = ActionStatusSelectorOption
