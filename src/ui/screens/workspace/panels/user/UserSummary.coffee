#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
UserChangedNameEvent  = require 'events/ui/UserChangedNameEvent'
UserChangedTitleEvent = require 'events/ui/UserChangedTitleEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
IdentityContext       = require 'ui/framework/mixins/IdentityContext'
Avatar                = React.createFactory(require 'ui/common/Avatar')
EditableInput         = React.createFactory(require 'ui/common/EditableInput')
Icon                  = React.createFactory(require 'ui/common/Icon')
Clock                 = React.createFactory(require 'ui/common/Clock')
{div}                 = React.DOM
#--------------------------------------------------------------------------------
require './UserSummary.styl'
#--------------------------------------------------------------------------------

UserSummary = React.createClass {

  displayName: 'UserSummary'

  propTypes:
    user:    PropTypes.User
    profile: PropTypes.Profile

  mixins: [Actor, IdentityContext]

  render: ->

    div {className: 'user-summary'},
      Avatar {size: 54, user: @props.user, presence: true}
      div {className: 'user-summary-right'},
        @renderUserName()
        @renderTitle()
        div {className: 'user-local-time'},
          Icon {name: 'clock'}
          Clock {timezone: @props.user.timezone, format: 'LT z ([UTC]Z)'}

  renderUserName: ->
    if @props.user.id == @getCurrentUser().id
      EditableInput {className: 'user-name', value: @props.user.name, save: @changeName}
    else
      div {className: 'user-name'}, @props.user.name

  renderTitle: ->
    if @props.user.id == @getCurrentUser().id
      EditableInput {className: 'user-title', value: @props.profile.title, placeholder: "What's your role?", save: @changeTitle}
    else
      div {className: 'user-title'}, @props.profile.title

  changeName: (name) ->
    @publish new UserChangedNameEvent(name)

  changeTitle: (title) ->
    @publish new UserChangedTitleEvent(title)

}

module.exports = UserSummary
