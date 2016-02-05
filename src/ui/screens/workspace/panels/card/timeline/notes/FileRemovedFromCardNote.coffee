#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
FileWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/FileWidget')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}        = React.DOM
#--------------------------------------------------------------------------------

FileRemovedFromCardNote = React.createClass {

  displayName: 'FileRemovedFromCardNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    {file: cache('files').get(@props.note.content.file)}

  render: ->

    ActivityNote {icon: 'unlink'},
      UserWidget {user: @props.user}
      'unlinked'
      FileWidget {file: @state.file}
      'from the card'
      Time {relative: true, time: @props.note.created}

}

module.exports = FileRemovedFromCardNote
