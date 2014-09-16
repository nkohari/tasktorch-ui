Channel = require './Channel'

global.Bus = module.exports =
  cards:  new Channel('cards')
  stacks: new Channel('stacks')
