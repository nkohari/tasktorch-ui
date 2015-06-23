#--------------------------------------------------------------------------------
forms      = require 'newforms'
superagent = require 'superagent'
Request    = require 'data/framework/Request'
#--------------------------------------------------------------------------------

CreateUserForm = forms.Form.extend {

  username: forms.CharField
    label: 'Username'
    minLength: 3
    maxLength: 30
    widgetAttrs: {autoFocus: true}

  name: forms.CharField
    label: 'Name'

  email: forms.EmailField
    label: 'Email address'

  password: forms.CharField
    label: 'Password'
    widget: forms.PasswordInput

  passwordConfirm: forms.CharField
    label: 'Password (confirm)'
    widget: forms.PasswordInput

  clean: (callback) ->
    {password, passwordConfirm} = @cleanedData
    if (password and passwordConfirm and password != passwordConfirm)
      @addError('passwordConfirm', forms.ValidationError("Passwords do not match."))
    callback()

  cleanUsername: (callback) ->
    {username} = @cleanedData
    superagent.get(Request.urlFor("/users/exists?username=#{username}")).withCredentials().end (err, res) ->
      return callback(err) if err?
      return callback()    unless res.body.exists
      callback(null, forms.ValidationError("This username is already in use."))

  cleanEmail: (callback) ->
    {email} = @cleanedData
    superagent.get(Request.urlFor("/users/exists?email=#{email}")).withCredentials().end (err, res) ->
      return callback(err) if err?
      return callback()    unless res.body.exists
      callback(null, forms.ValidationError("This email address is already in use."))

}

module.exports = CreateUserForm
