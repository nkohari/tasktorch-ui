#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
Router        = require 'react-router'
CachedState   = require 'ui/framework/mixins/CachedState'
Icon          = React.createFactory(require 'ui/common/Icon')
Modal         = React.createFactory(require 'ui/common/Modal')
ModalMessage  = React.createFactory(require 'ui/common/ModalMessage')
{div, li, ul} = React.DOM
#--------------------------------------------------------------------------------
require './SelectOrgModal.styl'
#--------------------------------------------------------------------------------

SelectOrgModal = React.createClass {

  displayName: 'SelectOrgModal'

  mixins: [CachedState, Router.Navigation]

  getCachedState: (cache) -> {
    orgs: cache('myOrgs').get()
  }

  componentWillMount: ->
    Environment.cache.clear()
    Environment.messageBus.reset()

  render: ->

    items = _.map @state.orgs, (org) =>
      li {key: org.id, className: 'org', onClick: @selectOrg.bind(this, org)},
        Icon {name: 'org'}
        div {className: 'org-info'},
          div {className: 'org-name'}, org.name
          div {className: 'org-member-count'}, "#{org.members.length} Member#{if org.members.length == 1 then '' else 's'}"

    Modal {title: 'My Organizations', className: 'select-org-modal'},
      div {className: 'orgs'},
        div {className: 'header'}, 'My Organizations'
        ul {className: 'org-list'}, items
      ModalMessage {},
        "Which organization would you like to view?"

  selectOrg: (org) ->
    @transitionTo('workspace', {orgid: org.id})

}

module.exports = SelectOrgModal
