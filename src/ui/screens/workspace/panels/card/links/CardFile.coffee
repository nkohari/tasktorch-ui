#--------------------------------------------------------------------------------
React                        = require 'react'
Request                      = require 'data/framework/Request'
UserOpenedDialogEvent        = require 'events/ui/UserOpenedDialogEvent'
UserRemovedFileFromCardEvent = require 'events/ui/UserRemovedFileFromCardEvent'
PropTypes                    = require 'ui/framework/PropTypes'
Actor                        = require 'ui/framework/mixins/Actor'
Icon                         = React.createFactory(require 'ui/common/Icon')
FileName                     = React.createFactory(require 'ui/common/FileName')
FileIcon                     = React.createFactory(require 'ui/common/FileIcon')
{a, div, img}                = React.DOM
#--------------------------------------------------------------------------------
require './CardFile.styl'
#--------------------------------------------------------------------------------

CardFile = React.createClass {

  displayName: 'CardFile'

  propTypes:
    card: PropTypes.Card
    file: PropTypes.File

  mixins: [Actor]

  render: ->

    classes = ['card-file-overlay']

    if @props.file.thumbnail?
      preview = img {src: Request.urlFor(@props.file.thumbnail)}
      classes.push('can-lightbox')
      onClick = @showLightbox
    else
      preview = FileIcon {filename: @props.file.name}

    div {className: 'card-file'},
      div {className: 'card-file-preview'},
        preview
        div {className: classes.join(' '), onClick},
          a {className: 'remove', onClick: @onRemoveClicked},
            Icon {name: 'remove'}
          a {className: 'download', href: Request.urlFor("#{@props.file.url}?download=true"), onClick: @onDownloadClicked},
            Icon {name: 'download'}
      div {className: 'card-file-caption'},
        FileName {filename: @props.file.name}

  showLightbox: ->
    @publish new UserOpenedDialogEvent('FileLightbox', {fileid: @props.file.id})

  onDownloadClicked: (event) ->
    event.stopPropagation()

  onRemoveClicked: (event) ->
    event.stopPropagation()
    @publish new UserRemovedFileFromCardEvent(@props.card.id, @props.file.id)

}

module.exports = CardFile
