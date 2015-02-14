React    = require 'react'
Icon     = React.createFactory(require 'ui/common/Icon')
{a, div} = React.DOM

CardBlockHeader = React.createClass {

  displayName: 'CardBlockHeader'

  render: ->
    div {className: 'header'}, @props.children

}

module.exports = CardBlockHeader