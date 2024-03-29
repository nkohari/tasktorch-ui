_          = require 'lodash'
moment     = require 'moment'
superagent = require 'superagent'
Request    = require 'data/framework/Request'

if TASKTORCH_FLAGS_DEBUG
  INTERCOM_APPID = 'm48cllxy'
else
  INTERCOM_APPID = 'y3il7gkh'

Analytics = {}

Analytics.init = (user, org) ->
  superagent.get(Request.urlFor('/_intercom'))
  .withCredentials()
  .end (err, res) =>
    {token} = res.body
    debug.log("Analytics: Initialized for user %o", user)
    Intercom('boot', {
      app_id:     INTERCOM_APPID
      user_id:    user.id
      user_hash:  token
      name:       user.name
      email:      user.email
      created_at: moment(user.created).unix()
      is_leader:  _.includes(org.leaders, user.id)
      user_agent: window.navigator.userAgent
      widget:
        activator: '#intercom'
      company:
        id:   org.id
        name: org.name
    })

Analytics.update = (info = undefined) ->
  Intercom('update', info)

Analytics.showHelp = () ->
  Intercom('show')

Analytics.recordEvent = (name, metadata = undefined) ->
  debug.log("Analytics: Recorded event #{name}: %o", metadata)
  Intercom('trackEvent', name, metadata)

module.exports = Analytics
