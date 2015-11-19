_                        = require 'lodash'
SingletonListStore       = require 'data/framework/SingletonListStore'
LoadMyMembershipsRequest = require 'data/requests/LoadMyMembershipsRequest'

class MyMembershipsStore extends SingletonListStore

  displayName: 'MyMembershipsStore'
  name:        'myMemberships'
  dependsOn:   'memberships'

  listensFor: [
    'MyMembershipsLoaded'
  ]

  load: ->
    @execute new LoadMyMembershipsRequest()

  onMyMembershipsLoaded: (event) ->
    @set(_.pluck(event.memberships, 'id'))

module.exports = MyMembershipsStore
