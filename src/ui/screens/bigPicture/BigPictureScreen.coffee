_       = require 'lodash'
React   = require 'react'
Observe = require 'framework/mixins/Observe'
{div}   = React.DOM

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [
    Observe()
  ]

  render: ->
    div {className: 'bigpicture screen'}, [
    ]

}

module.exports = BigPictureScreen
