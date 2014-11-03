_       = require 'lodash'
React  = require 'react'
Router = require 'react-router'
{div}  = React.DOM

BigPictureScreen = React.createClass {

  displayName: 'BigPictureScreen'

  mixins: [Router.Navigation]

  render: ->
    div {className: 'big-picture screen'}, [
    ]
}

module.exports = BigPictureScreen
