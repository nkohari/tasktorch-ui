_                     = require 'lodash'
ListStore             = require 'data/framework/ListStore'
LoadKindsByOrgRequest = require 'data/requests/LoadKindsByOrgRequest'

class KindsByOrgStore extends ListStore

  displayName: 'KindsByOrgStore'
  name:        'kindsByOrg'
  dependsOn:   'kinds'

  listensFor: [
    'KindsByOrgLoaded'
    'KindCreated'
  ]

  load: (id) ->
    @execute new LoadKindsByOrgRequest(id)

  onKindsByOrgLoaded: (event) ->
    kinds = _.sortBy event.kinds, (kind) -> kind.name.toLowerCase()
    @set(event.orgid, _.pluck(kinds, 'id'))

  onKindCreated: (event) ->
    @remove(event.kind.org)

module.exports = KindsByOrgStore
