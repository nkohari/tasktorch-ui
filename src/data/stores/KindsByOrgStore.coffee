_                     = require 'lodash'
ListStore             = require 'data/framework/ListStore'
LoadKindsByOrgRequest = require 'data/requests/LoadKindsByOrgRequest'

class KindsByOrgStore extends ListStore

  displayName: 'KindsByOrgStore'
  name:        'kindsByOrg'
  dependsOn:   'kinds'

  listensFor: [
    'KindsByOrgLoaded'
  ]

  load: (id) ->
    @execute new LoadKindsByOrgRequest(id)

  onKindsByOrgLoaded: (event) ->
    @set(event.orgid, _.pluck(event.kinds, 'id'))

module.exports = KindsByOrgStore
