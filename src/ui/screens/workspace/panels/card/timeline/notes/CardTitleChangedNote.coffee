#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Icon           = React.createFactory(require 'ui/common/Icon')
Time           = React.createFactory(require 'ui/common/Time')
ActivityNote   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
ExpandableDiff = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/ExpandableDiff')
UserWidget     = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}          = React.DOM
#--------------------------------------------------------------------------------

CardTitleChangedNote = React.createClass {

  displayName: 'CardTitleChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    ActivityNote {@isReady, icon: 'edit'},
      UserWidget {user: @props.user}
      'changed the title'
      Time {relative: true, time: @props.note.created}
      ExpandableDiff {from: @props.note.content.from, to: @props.note.content.to}

}

module.exports = CardTitleChangedNote
