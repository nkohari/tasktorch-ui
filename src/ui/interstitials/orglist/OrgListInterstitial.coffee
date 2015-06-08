_             = require 'lodash'
React         = require 'react'
Router        = require 'react-router'
CachedState   = require 'ui/framework/mixins/CachedState'
Icon          = React.createFactory(require 'ui/common/Icon')
{div, li, ul} = React.DOM

OrgListInterstitial = React.createClass {

  displayName: 'OrgListInterstitial'

  mixins: [CachedState, Router.Navigation]

  getCachedState: (cache) -> {
    orgs: cache('myOrgs').get()
  }

  componentWillMount: ->
    Environment.cache.clear()

  componentDidMount: ->
    document.title = "TaskTorch | My Organizations"

  render: ->

    items = _.map @state.orgs, (org) =>
      li {key: org.id, className: 'org', onClick: @selectOrg.bind(this, org)},
        Icon {name: 'org'}
        div {className: 'org-info'},
          div {className: 'org-name'}, org.name
          div {className: 'org-member-count'}, "#{org.members.length} Member#{if org.members.length == 1 then '' else 's'}"

    div {className: 'org-list interstitial'},
      div {className: 'orgs'},
        div {className: 'header'}, 'Which Organization?'
        ul {className: 'org-list'}, items
      div {className: 'brand'},
        'TaskTorch'
        div {className: 'version'}, 'Private Alpha'

  selectOrg: (org) ->
    @transitionTo('workspace', {orgid: org.id})

}

module.exports = OrgListInterstitial
