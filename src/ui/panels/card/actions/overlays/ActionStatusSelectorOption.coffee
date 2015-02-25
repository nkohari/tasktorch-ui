React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

ActionStatusSelectorOption = React.createClass {

  displayName: 'ActionStatusSelectorOption'

  propTypes:
    icon:   PropTypes.string
    text:   PropTypes.string
    value:  PropTypes.any

  render: ->

    div {},
      Icon {name: @props.icon}
      @props.text

}

module.exports = ActionStatusSelectorOption
