_                 = require 'lodash'
React             = require 'react'
Router            = require 'react-router'
ActiveUrl         = require 'mixins/ActiveUrl'
Observe           = require 'mixins/Observe'
BigPictureUrl     = require './BigPictureUrl'
BigPictureSidebar = React.createFactory(require './components/BigPictureSidebar')
{div}             = React.DOM

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [
    Observe()
    ActiveUrl(BigPictureUrl)
  ]

  render: ->

    div {className: 'bigpicture screen'}, [
      BigPictureSidebar {key: 'sidebar'}
    ]

}

module.exports = BigPictureScreen
