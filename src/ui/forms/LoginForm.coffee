#--------------------------------------------------------------------------------
forms = require 'newforms'
#--------------------------------------------------------------------------------

LoginForm = forms.Form.extend {

  login: forms.CharField
    label: 'Username or Email'
    required: true
    widgetAttrs: {autoFocus: true}

  password: forms.CharField
    label: 'Password'
    required: true
    widget: forms.PasswordInput

}

module.exports = LoginForm
