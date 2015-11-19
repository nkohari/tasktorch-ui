#--------------------------------------------------------------------------------
_             = require 'lodash'
React         = require 'react'
Router        = require 'react-router'
PropTypes     = require 'ui/framework/PropTypes'
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

  contextTypes:
    environment: PropTypes.object

  mixins: [CachedState, Router.History]

  getCachedState: (cache) -> {
    orgs: cache('myOrgs').get()
  }

  componentWillMount: ->
    @context.environment.get('cache').clear()
    @context.environment.get('viewMaster').reset()
    @context.environment.get('messageBus').reset()
    @context.environment.get('processor').reset()

  render: ->

    items = _.map @state.orgs, (org) =>
      li {key: org.id, className: 'org', onClick: @selectOrg.bind(this, org)},
        Icon {name: 'org'}
        div {className: 'org-info'},
          div {className: 'org-name'}, org.name

    Modal {title: 'My Organizations', className: 'select-org-modal'},
      div {className: 'orgs'},
        div {className: 'header'}, 'My Organizations'
        ul {className: 'org-list'}, items
      ModalMessage {},
        "Which organization would you like to view?"

  selectOrg: (org) ->
    @history.pushState(null, "/#{org.id}/workspace")

}

module.exports = SelectOrgModal
