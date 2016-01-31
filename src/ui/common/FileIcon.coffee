#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM
#--------------------------------------------------------------------------------
require './FileIcon.styl'
#--------------------------------------------------------------------------------

FileIcon = React.createClass {

  displayName: 'FileIcon'

  propTypes:
    filename: PropTypes.string

  render: ->

    index = @props.filename.lastIndexOf('.')

    if index > 0
      extension = div {className: 'extension'}, @props.filename.substr(index + 1)

    div {className: 'file-icon'},
      extension
      Icon {name: 'document'}

}

module.exports = FileIcon
