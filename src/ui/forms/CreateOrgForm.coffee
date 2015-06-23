#--------------------------------------------------------------------------------
forms = require 'newforms'
#--------------------------------------------------------------------------------

CreateOrgForm = forms.Form.extend {

  name: forms.CharField
    label: 'Organization name'
    widgetAttrs: {autoFocus: true}

  tsp: forms.ChoiceField
    label: 'How many people are in your organization?'
    choices: [
      [null, 'Please choose one']
      ['xs', 'Fewer than 10']
      ['sm', '10-100']
      ['md', '101-500']
      ['lg', 'More than 500']
    ]

  size: forms.ChoiceField
    label: 'How many people will use TaskTorch?'
    choices: [
      [null, 'Please choose one']
      ['xs', 'Fewer than 10']
      ['sm', '10-100']
      ['md', '101-500']
      ['lg', 'More than 500']
    ]

  role: forms.ChoiceField
    label: 'What is your role at the company?'
    choices: [
      [null,       'Please choose one']
      ['employee', 'Individual contributor']
      ['manager',  'Manager or team leader']
      ['director', 'Director or vice president']
      ['exec',     'Executive leader']
    ]

  kinds: forms.MultipleChoiceField
    label: 'What kinds of work do you hope to manage?'
    widget: forms.CheckboxSelectMultiple
    required: false
    choices: [
      ['software',   'Software development']
      ['devops',     'Technical operations (devops)']
      ['design',     'Graphical design']
      ['sales',      'Sales']
      ['marketing',  'Marketing']
      ['recruiting', 'Recruiting and hiring']
      ['support',    'Customer support']
      ['ops',        'Business operations']
    ]

}

module.exports = CreateOrgForm
