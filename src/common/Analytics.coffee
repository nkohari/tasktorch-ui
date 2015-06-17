_          = require 'lodash'
moment     = require 'moment'
superagent = require 'superagent'
Request    = require 'data/framework/Request'

INTERCOM_APPID = 'y3il7gkh'

Analytics = {}

Analytics.init = (user, org) ->
  superagent.get(Request.urlFor('/_intercom'))
  .withCredentials()
  .end (err, res) =>
    {token} = res.body
    Intercom('boot', {
      app_id:     INTERCOM_APPID
      user_id:    user.id
      user_hash:  token
      name:       user.name
      email:      user.email
      created_at: moment(user.created).unix()
      is_leader:  _.contains(org.leaders, user.id)
      widget:
        activator:  '#intercom'
      company:
        id:         org.id
        name:       org.name
        created_at: moment(org.created).unix()
        members:    _.size(org.members)
    })

Analytics.update = (info = undefined) ->
  Intercom('update', info)

Analytics.showHelp = () ->
  Intercom('show')

module.exports = Analytics
