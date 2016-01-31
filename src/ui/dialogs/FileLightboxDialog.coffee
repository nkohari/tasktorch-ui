#--------------------------------------------------------------------------------
filesize      = require 'filesize'
React         = require 'react'
Request       = require 'data/framework/Request'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
Button        = React.createFactory(require 'ui/common/Button')
Icon          = React.createFactory(require 'ui/common/Icon')
Dialog        = React.createFactory(require 'ui/common/Dialog')
DialogFooter  = React.createFactory(require 'ui/common/DialogFooter')
{a, div, img} = React.DOM
#--------------------------------------------------------------------------------
require './FileLightboxDialog.styl'
#--------------------------------------------------------------------------------

FileLightboxDialog = React.createClass {

  displayName: 'FileLightboxDialog'

  propTypes:
    fileid:      PropTypes.File
    closeDialog: PropTypes.func

  mixins: [CachedState]

  getCachedState: (cache) ->
    {file: cache('files').get(@props.fileid)}

  render: ->

    if @state.file?
      label = "Download (#{filesize(@state.file.size)})"
    else
      label = "Download"

    footer = DialogFooter {
      left: [
        a {className: 'button', href: Request.urlFor("#{@state.file.url}?download=true")},
          Icon {name: 'download'}
          label
      ]
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'file', title: @state.file?.name, width: '80vw', height: '80vh', className: 'file-lightbox-dialog', footer, closeDialog: @props.closeDialog},
      img {src: Request.urlFor(@state.file.url)}

}

module.exports = FileLightboxDialog
