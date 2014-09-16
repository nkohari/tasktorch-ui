path       = require 'path'
express    = require 'express'
bodyParser = require 'body-parser'

app = express()

app.use '/', express.static(path.resolve(__dirname, '..'))
app.use bodyParser.json()

require('./handlers/cards').register(app)
require('./handlers/stacks').register(app)

module.exports = app
