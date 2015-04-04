React      = require 'react'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
{span}     = React.DOM

KindIcon = React.createClass {

  displayName: 'KindIcon'

  propTypes:
    kind: PropTypes.Kind

  render: ->

    classes = classSet [
      'kind-icon'
      @props.kind.color if @props.kind?
    ]

    props = mergeProps @props, {
      name: 'card'
      className: classes
    }

    Icon props

}

module.exports = KindIcon
