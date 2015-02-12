_       = require 'lodash'
React   = require 'react'
Observe = require 'framework/mixins/Observe'
Frame   = React.createFactory(require 'ui/common/Frame')

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [
    Observe()
  ]

  render: ->

    Frame {className: 'screen'}

}

module.exports = BigPictureScreen
