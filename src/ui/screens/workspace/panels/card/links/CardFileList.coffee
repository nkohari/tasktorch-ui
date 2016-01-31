#--------------------------------------------------------------------------------
React           = require 'react'
CardCommandType = require 'data/enums/CardCommandType'
PropTypes       = require 'ui/framework/PropTypes'
CachedState     = require 'ui/framework/mixins/CachedState'
CommandContext  = require 'ui/framework/mixins/CommandContext'
Icon            = React.createFactory(require 'ui/common/Icon')
CardFile        = React.createFactory(require 'ui/screens/workspace/panels/card/links/CardFile')
CardLinkSection = React.createFactory(require 'ui/screens/workspace/panels/card/links/CardLinkSection')
{div, ul}       = React.DOM
#--------------------------------------------------------------------------------
require './CardFileList.styl'
#--------------------------------------------------------------------------------

CardFileList = React.createClass {

  displayName: 'CardFileList'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, CommandContext]

  getCachedState: (cache) ->
    {files: cache('filesByCard').get(@props.card.id)}

  render: ->

    items = _.map @state.files, (file) =>
      CardFile {key: file.id, file, card: @props.card}

    controls = Icon {name: 'add', onClick: @openAttachCommand}

    CardLinkSection {icon: 'file', title: 'Files', count: @state.files?.length, controls},
      ul {className: 'card-file-list'},
        items

  openAttachCommand: ->
    @showCommand(CardCommandType.Attach)

}

module.exports = CardFileList
