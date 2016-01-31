#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM
#--------------------------------------------------------------------------------
require './FileName.styl'
#--------------------------------------------------------------------------------

FileName = React.createClass {

  displayName: 'FileName'

  propTypes:
    filename: PropTypes.string

  render: ->

    split = @props.filename.lastIndexOf('.')

    if split < 0
      name = div {className: 'name'},
        @props.filename
    else
      name = div {className: 'name'},
        @props.filename.substr(0, split)
      extension = div {className: 'extension'},
        @props.filename.substr(split)

    div {className: 'file-name'},
      name
      extension

}

module.exports = FileName
