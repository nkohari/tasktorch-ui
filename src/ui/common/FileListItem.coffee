#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
FileName   = React.createFactory(require 'ui/common/FileName')
FileIcon   = React.createFactory(require 'ui/common/FileIcon')
{div, img} = React.DOM
#--------------------------------------------------------------------------------
require './FileListItem.styl'
#--------------------------------------------------------------------------------

FileListItem = React.createClass {

  displayName: 'FileListItem'

  propTypes:
    file:       PropTypes.object
    removeFile: PropTypes.func

  componentWillMount: ->
    @url = URL.createObjectURL(@props.file.handle)

  componentWillReceiveProps: (newProps) ->
    URL.revokeObjectURL(@url) if @url?
    @url = URL.createObjectURL(newProps.file.handle)

  componentWillUnmount: ->
    URL.revokeObjectURL(@url)

  render: ->

    if @props.file.name.match(/(jpg|jpeg|png|gif)$/)
      preview = div {className: 'thumbnail', style: {backgroundImage: "url(#{@url})"}}
    else
      preview = FileIcon {filename: @props.file.name}

    div {className: 'file-list-item'},
      div {className: 'file-list-item-preview'},
        preview
        div {className: 'file-list-item-overlay', onClick: @props.removeFile},
          Icon {name: 'remove'}
      FileName {filename: @props.file.name}

}

module.exports = FileListItem
