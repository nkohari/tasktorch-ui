KindColor = require 'data/enums/KindColor'

KindTemplates = []

KindTemplates.push {
  id: '1'
  name: 'Task'
  color: KindColor.Blue
  description: 'General purpose, can be used to track anything'
  stages: [
    {
      id: '11'
      name: 'Plan'
      defaultActions: []
    }
    {
      id: '12'
      name: 'Do'
      defaultActions: []
    }
    {
      id: '13'
      name: 'Verify'
      defaultActions: []
    }
  ]
}

KindTemplates.push {
  id: '2'
  name: 'Feature'
  color: KindColor.Green
  description: 'Develop new software features'
  stages: [
    {
      id: '21'
      name: 'Design'
      defaultActions: [
        {id: '211', text: 'Define requirements for feature'}
        {id: '211', text: 'Review requirements with team'}
      ]
    }
    {
      id: '22'
      name: 'Develop'
      defaultActions: [
        {id: '221', text: 'Implement the feature'}
      ]
    }
    {
      id: '23'
      name: 'Test'
      defaultActions: [
        {id: '231', text: 'Requirements review'}
        {id: '232', text: 'Code review'}
      ]
    }
    {
      id: '24'
      name: 'Deliver'
      defaultActions: [
        {id: '241', text: 'Deploy code to production'}
      ]
    }
  ]
}

KindTemplates.push {
  id: '3'
  name: 'Bug'
  color: KindColor.Red
  description: 'Fix software defects'
  stages: [
    {
      id: '31'
      name: 'Confirm'
      defaultActions: [
        {id: '311', text: 'Document steps to reproduce issue'}
      ]
    }
    {
      id: '32'
      name: 'Develop'
      defaultActions: [
        {id: '321', text: 'Investigate the cause'}
        {id: '322', text: 'Implement fix'}
      ]
    }
    {
      id: '33'
      name: 'Test'
      defaultActions: [
        {id: '331', text: 'Confirm that changes fix the issue'}
        {id: '332', text: 'Code review'}
      ]
    }
    {
      id: '34'
      name: 'Deliver'
      defaultActions: [
        {id: '341', text: 'Deploy code to production'}
        {id: '342', text: 'Inform reporter that the bug is fixed'}
      ]
    }
  ]
}

KindTemplates.push {
  id: '4'
  name: 'Support Case'
  color: KindColor.Yellow
  description: 'Handle customer support requests'
  stages: [
    {
      id: '41'
      name: 'Checklist'
      defaultActions: [
        {id: '411', text: 'Verify customer issue'}
        {id: '412', text: 'Respond to customer'}
      ]
    }
  ]
}

KindTemplates.push {
  id: '5'
  name: 'Documentation'
  color: KindColor.Purple
  description: 'Create content for help documentation'
  stages: [
    {
      id: '51'
      name: 'Prepare'
      defaultActions: [
        {id: '511', text: 'Collect necessary information'}
      ]
    }
    {
      id: '52'
      name: 'Write'
      defaultActions: [
        {id: '521', text: 'Write copy'}
        {id: '522', text: 'Create visuals'}
      ]
    }
    {
      id: '53'
      name: 'Review'
      defaultActions: [
        {id: '531', text: 'Review documentation with team'}
      ]
    }
    {
      id: '54'
      name: 'Deliver'
      defaultActions: [
        {id: '541', text: 'Add documentation to knowledge base'}
      ]
    }
  ]
}

KindTemplates.push {
  id: '6'
  name: 'Job Applicant'
  color: KindColor.Cyan
  description: 'Track candidates through the hiring process'
  stages: [
    {
      id: '61'
      name: 'Review Application'
      defaultActions: [
        {id: '611', text: 'Review resume'}
      ]
    }
    {
      id: '62'
      name: 'Screening'
      defaultActions: [
        {id: '621', text: 'Schedule phone interview'}
        {id: '622', text: 'Conduct phone interview'}
        {id: '623', text: 'Review with hiring team'}
      ]
    }
    {
      id: '63'
      name: 'Interview'
      defaultActions: [
        {id: '631', text: 'Schedule in-person interview'}
        {id: '632', text: 'Conduct in-person interview'}
        {id: '633', text: 'Review with hiring team'}
      ]
    }
    {
      id: '64'
      name: 'Hire'
      defaultActions: [
        {id: '641', text: 'Create offer letter'}
        {id: '642', text: 'Deliver offer letter to candidate'}
        {id: '643', text: 'Receive signed offer letter'}
      ]
    }
  ]
}

KindTemplates.push {
  id: '7'
  name: 'Sales Lead'
  color: KindColor.LightGreen
  description: 'Track inbound leads through the sales process'
  stages: [
    {
      id: '71'
      name: 'Qualify Lead'
      defaultActions: [
        {id: '711', text: 'Review customer inquiry'}
        {id: '711', text: 'Ensure product fit'}
      ]
    }
    {
      id: '72'
      name: 'Discovery'
      defaultActions: [
        {id: '721', text: 'Schedule call with customer'}
        {id: '722', text: 'Gather information about customer\'s needs'}
      ]
    }
    {
      id: '73'
      name: 'Demo'
      defaultActions: [
        {id: '731', text: 'Schedule product demonstration with customer'}
        {id: '732', text: 'Demonstrate product'}
      ]
    }
    {
      id: '74'
      name: 'Sign'
      defaultActions: [
        {id: '741', text: 'Draft proposed contract'}
        {id: '742', text: 'Deliver contract to customer'}
        {id: '743', text: 'Receive signed contract from customer'}
      ]
    }
    {
      id: '75'
      name: 'On-Board'
      defaultActions: [
        {id: '751', text: 'Create on-boarding schedule'}
        {id: '751', text: 'On-board customer'}
      ]
    }
  ]
}

module.exports = KindTemplates
