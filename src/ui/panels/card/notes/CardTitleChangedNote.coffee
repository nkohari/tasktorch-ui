_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Avatar      = React.createFactory(require 'ui/common/Avatar')
Icon        = React.createFactory(require 'ui/common/Icon')
Time        = React.createFactory(require 'ui/common/Time')
{a, div, span} = React.DOM

CardTitleChangedNote = React.createClass {

  displayName: 'CardTitleChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  getInitialState: ->
    {expanded: false}

  render: ->

    div {className: 'activity'},
      Icon {name: 'create-card'}
      div {className: 'activity-body'},
        span {className: 'activity-user'},
          Avatar {user: @props.user}
          @props.user.name
        ' changed the title '
        Time {relative: true, time: @props.note.time}
        a {className: 'activity-change-toggle', onClick: @toggleChangeDisplay},
          if @state.expanded then 'hide' else 'show'
        @renderChange() if @state.expanded

  renderChange: ->

    div {className: 'activity-change'},
      div {className: 'activity-change-item'},
        div {className: 'activity-change-label'}, 'from:'
        div {className: 'activity-change-value'}, @props.note.content.from
      div {className: 'activity-change-item'},
        div {className: 'activity-change-label'}, 'to:'
        div {className: 'activity-change-value'}, @props.note.content.to

  toggleChangeDisplay: ->
    @setState {expanded: !@state.expanded}

}

module.exports = CardTitleChangedNote
