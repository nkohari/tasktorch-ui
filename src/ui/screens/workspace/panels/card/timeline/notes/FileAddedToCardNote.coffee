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

FileAddedToCardNote = React.createClass {

  displayName: 'FileAddedToCardNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    {file: cache('files').get(@props.note.content.file)}

  render: ->

    ActivityNote {icon: 'link'},
      UserWidget {user: @props.user}
      'linked'
      FileWidget {file: @state.file}
      'to the card'
      Time {relative: true, time: @props.note.created}

}

module.exports = FileAddedToCardNote
