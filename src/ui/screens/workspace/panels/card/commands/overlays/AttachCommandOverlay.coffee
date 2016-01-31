#--------------------------------------------------------------------------------
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CommandContext     = require 'ui/framework/mixins/CommandContext'
IdentityContext    = require 'ui/framework/mixins/IdentityContext'
Button             = React.createFactory(require 'ui/common/Button')
FilePicker         = React.createFactory(require 'ui/common/FilePicker')
Prompt             = React.createFactory(require 'ui/common/Prompt')
CardCommandOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}              = React.DOM
#--------------------------------------------------------------------------------

AttachCommandOverlay = React.createClass {

  displayName: 'AttachCommandOverlay'

  propTypes:
    card:  PropTypes.Card
    files: PropTypes.arrayOf(PropTypes.object)

  mixins: [CommandContext, IdentityContext]

  getDefaultProps: ->
    {files: []}

  getInitialState: ->
    {uploading: false, fileCount: @props.files.length}

  render: ->

    if @state.uploading
      label = 'Uploading'
    else if @state.fileCount < 2
      label = 'Upload file'
    else
      label = "Upload #{@state.fileCount} files"

    buttons = div {className: 'buttons'},
      Button {text: label, className: 'default', disabled: @state.uploading or @state.fileCount == 0, onClick: @startUpload}
      Button {text: 'Cancel', onClick: @hideCommand}

    CardCommandOverlay {className: 'attach-command-overlay', buttons},
      Prompt {},
        'Which files would you like to attach?'
      FilePicker {ref: 'filepicker', files: @props.files, org: @getCurrentOrg(), card: @props.card, onChange: @onFilesChanged, onComplete: @onUploadComplete}

  startUpload: ->
    @setState {uploading: true}
    @refs.filepicker?.startUpload()

  onFilesChanged: (files) ->
    @setState {fileCount: files.length}

  onUploadComplete: ->
    @hideCommand()

}

module.exports = AttachCommandOverlay
