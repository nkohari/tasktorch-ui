cards =
  c1:
    id:    'c1'
    type:  'bug'
    title: 'Fire hazard'
    body:  'When a user clicks the OK button their screen starts to smoke. That seems like a problem...'
    stack: 's1'
  c2:
    id:    'c2'
    type:  'feature'
    title: 'Build payment screen'
    body:  'We gotta be makin that money'
    stack: 's2'
  c3:
    id:    'c3'
    type:  'todo'
    title: 'Buy more printer toner'
    body:  ''
    stack: 's1'
  c4:
    id:    'c4'
    type:  'feature'
    title: 'Build new login screen'
    body:  'The old one is kind of janky'
    stack: 's1'
  c5:
    id:    'c5'
    type:  'support'
    title: 'Support request from Joe at Derp, Inc.'
    body:  'Hey, when I click the OK button, my screen starts to smoke. WTF?'
    customer: 'Derp, Inc.'
    stack: 's2'

stacks =
  s1: {id: 's1', name: 'Stack 1', cards: ['c1', 'c3', 'c4']}
  s2: {id: 's2', name: 'Stack 2', cards: ['c2', 'c5']}

module.exports = {cards, stacks}
