#--------------------------------------------------------------------------------
_                    = require 'lodash'
filesize             = require 'filesize'
React                = require 'react'
classSet             = require 'common/util/classSet'
FilePickerStatus     = require 'data/enums/FilePickerStatus'
UploadStatus         = require 'data/enums/UploadStatus'
UserCreatedFileEvent = require 'events/ui/UserCreatedFileEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
Button               = React.createFactory(require 'ui/common/Button')
FileListItem         = React.createFactory(require 'ui/common/FileListItem')
ProgressBar          = React.createFactory(require 'ui/common/ProgressBar')
ProgressBarSegment   = React.createFactory(require 'ui/common/ProgressBarSegment')
Spinner              = React.createFactory(require 'ui/common/Spinner')
{div, input, ul, li} = React.DOM
#--------------------------------------------------------------------------------
require './FilePicker.styl'
#--------------------------------------------------------------------------------

FilePicker = React.createClass {

  displayName: 'FilePicker'

  propTypes:
    org:        PropTypes.Org
    card:       PropTypes.Card
    files:      PropTypes.arrayOf(PropTypes.object)
    onChange:   PropTypes.func
    onComplete: PropTypes.func

  mixins: [Actor]

  getDefaultProps: ->
    {files: []}

  getInitialState: -> {
    status: FilePickerStatus.Selecting
    files: @_createFilesFromHandles(@props.files)
    totalBytes: 0
    percentComplete: 0
  }

  render: ->

    items = _.map @state.files, (file) =>
      FileListItem {key: file.name, file, removeFile: @removeFile.bind(this, file)}

    classes = classSet [
      'file-picker'
      'empty'    if @state.files.length == 0
      'hovering' if @state.hovering
    ]

    if @state.files.length == 0
      indicator = div {className: 'drop-indicator'},
        "Drag and drop files here"

    div {className: classes, @onDragOver, @onDragEnter, @onDragLeave, onDrop: @onDragDrop},
      div {className: 'file-list'},
        items
        indicator
      @renderStatus()

  renderStatus: ->
    if @state.status == FilePickerStatus.Selecting
      @renderFileCount()
    else if @state.status == FilePickerStatus.Uploading
      @renderProgressBar()
    else if @state.status == FilePickerStatus.Processing
      @renderProcessingSpinner()

  renderFileCount: ->

    if @state.files.length == 0
      label = "No files selected"
    else
      totalBytes = _.sumBy @state.files, (f) -> f.handle.size
      label = "#{@state.files.length} files (#{filesize(totalBytes)}) selected"

    div {className: 'file-picker-status'},
      div {className: 'right'},
        input {ref: 'input', type: 'file', name: 'files', multiple: true, onChange: @onFilesAdded}
        Button {className: 'small', text: "Select files from my computer", onClick: @onButtonClicked}
      div {className: 'left'},
        label

  renderProgressBar: ->

    percentComplete = _.sumBy(@state.files, (f) -> f.percentComplete) / @state.files.length

    div {className: 'file-picker-status'},
      ProgressBar {},
        ProgressBarSegment {className: 'complete', value: percentComplete}

  renderProcessingSpinner: ->

    div {className: 'file-picker-status'},
      "Processing uploaded files..."
      Spinner {}

  addFiles: (handles) ->
    newFiles = @_createFilesFromHandles(handles)
    files    = _.unionBy(@state.files, newFiles, (f) -> f.name)
    @setFiles(files)

  removeFile: (file) ->
    @setFiles(_.without(@state.files, file))

  setFiles: (files) ->
    @setState {files}
    @props.onChange(files) if @props.onChange?

  startUpload: ->
    @setState {status: FilePickerStatus.Uploading}
    _.each @state.files, (file) =>
      @publish new UserCreatedFileEvent(@props.org.id, @props.card.id, file.handle, {
        onProgress: @onUploadProgress.bind(this, file.name)
        onComplete: @onUploadComplete.bind(this, file.name)
      })

  onButtonClicked: ->
    @refs.input.getDOMNode().click()

  onFilesAdded: (event) ->
    @addFiles(event.target.files)

  onDragOver: (event) ->
    event.preventDefault()
    event.stopPropagation()

  onDragEnter: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @setState {hovering: true}

  onDragLeave: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @setState {hovering: false}

  onDragDrop: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @setState {hovering: false}
    @addFiles(event.dataTransfer.files)

  onUploadProgress: (filename, event) ->
    files = _.clone(@state.files)

    file = _.find files, (f) -> f.name == filename
    file.state = UploadStatus.InProgress
    file.percentComplete = event.percent

    if _.every(files, (f) -> f.percentComplete == 100)
      @setState {status: FilePickerStatus.Processing}
      
    @setFiles(files)

  onUploadComplete: (filename) ->
    files = _.clone(@state.files)

    file = _.find files, (f) -> f.name == filename
    file.state = UploadStatus.Complete
    file.percentComplete = 100

    if _.every(files, (f) -> f.percentComplete == 100)
      @props.onComplete()
    else
      @setFiles(files)

  _createFilesFromHandles: (handles) ->
    _.map handles, (handle) -> {
      handle
      name: handle.name
      state: UploadStatus.NotStarted
      percentComplete: 0
    }

}

module.exports = FilePicker
