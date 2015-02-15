_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
{li}      = React.DOM

MenuItem = React.createClass {

  displayName: 'MenuItem'

  propTypes:
    value: PropTypes.any

  render: ->

    props = _.omit(@props, 'value')
    li props, @props.children

}

module.exports = MenuItem
