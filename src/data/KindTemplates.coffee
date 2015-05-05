KindColor = require 'data/enums/KindColor'

KindTemplates = []

KindTemplates.push {
  name: 'Task'
  color: KindColor.Blue
  description: 'General purpose, can be used to track anything'
  stages: [
    {id: '1', name: 'Plan',  actions: [{id: '1', text: 'One'}, {id: '4', text: 'Example'}]}
    {id: '2', name: 'Do',    actions: [{id: '2', text: 'Two'}]}
    {id: '3', name: 'Check', actions: [{id: '3', text: 'Three'}]}
  ]
}

KindTemplates.push {
  name: 'Task'
  color: KindColor.Green
  description: 'General purpose, can be used to track anything'
  stages: [
    {name: 'Plan',  actions: []}
    {name: 'Do',    actions: []}
    {name: 'Check', actions: []}
  ]
}

KindTemplates.push {
  name: 'Task'
  color: KindColor.Green
  description: 'General purpose, can be used to track anything'
  stages: [
    {name: 'Plan',  actions: []}
    {name: 'Do',    actions: []}
    {name: 'Check', actions: []}
  ]
}

KindTemplates.push {
  name: 'Task'
  color: KindColor.Green
  description: 'General purpose, can be used to track anything'
  stages: [
    {name: 'Plan',  actions: []}
    {name: 'Do',    actions: []}
    {name: 'Check', actions: []}
  ]
}

module.exports = KindTemplates
