KindColor = require 'data/enums/KindColor'

KindTemplates = []

KindTemplates.push {
  id: '1'
  name: 'Task'
  color: KindColor.Blue
  description: 'General purpose, can be used to track anything'
  stages: [
    {id: '1', name: 'Plan',  defaultActions: [{id: '1', text: 'One'}, {id: '4', text: 'Example'}]}
    {id: '2', name: 'Do',    defaultActions: [{id: '2', text: 'Two'}]}
    {id: '3', name: 'Check', defaultActions: [{id: '3', text: 'Three'}]}
  ]
}

KindTemplates.push {
  id: '2'
  name: 'Task'
  color: KindColor.Green
  description: 'General purpose, can be used to track anything'
  stages: [
    {name: 'Plan',  defaultActions: []}
    {name: 'Do',    defaultActions: []}
    {name: 'Check', defaultActions: []}
  ]
}

KindTemplates.push {
  id: '3'
  name: 'Task'
  color: KindColor.Green
  description: 'General purpose, can be used to track anything'
  stages: [
    {name: 'Plan',  defaultActions: []}
    {name: 'Do',    defaultActions: []}
    {name: 'Check', defaultActions: []}
  ]
}

KindTemplates.push {
  id: '4'
  name: 'Task'
  color: KindColor.Green
  description: 'General purpose, can be used to track anything'
  stages: [
    {name: 'Plan',  defaultActions: []}
    {name: 'Do',    defaultActions: []}
    {name: 'Check', defaultActions: []}
  ]
}

module.exports = KindTemplates
