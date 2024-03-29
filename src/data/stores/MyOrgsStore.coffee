_                  = require 'lodash'
SingletonListStore = require 'data/framework/SingletonListStore'
LoadMyOrgsRequest  = require 'data/requests/LoadMyOrgsRequest'

class MyOrgsStore extends SingletonListStore

  displayName: 'MyOrgsStore'
  name:        'myOrgs'
  dependsOn:   'orgs'

  listensFor: [
    'MyOrgsLoaded'
  ]

  load: ->
    @execute new LoadMyOrgsRequest()

  onMyOrgsLoaded: (event) ->
    orgs = _.sortBy event.orgs, (org) -> org.name.toLowerCase()
    @set(_.map(orgs, 'id'))

module.exports = MyOrgsStore
