React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
{span}     = React.DOM

KindIcon = React.createClass {

  displayName: 'KindIcon'

  propTypes:
    kind: PropTypes.Kind

  render: ->

    if @props.kind?
      style = {color: @props.kind.color}

    props = mergeProps @props, {name: 'dot', style}

    Icon props

}

module.exports = KindIcon
