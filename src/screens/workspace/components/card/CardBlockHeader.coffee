React    = require 'react'
Icon     = React.createFactory(require 'common/Icon')
{a, div} = React.DOM

CardBlockHeader = React.createClass {

  displayName: 'CardBlockHeader'

  render: ->
    div {className: 'header'}, @props.children

}

module.exports = CardBlockHeader
