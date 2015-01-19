_            = require 'lodash'
React        = require 'react'
ActionStatus = require 'framework/enums/ActionStatus'

PropTypes = _.extend {}, React.PropTypes

PropTypes.id      = PropTypes.string
PropTypes.idArray = PropTypes.arrayOf(PropTypes.id)
PropTypes.enum    = (hash) -> PropTypes.oneOf _.values(hash)

PropTypes.model = (spec) ->
  PropTypes.shape _.extend {
    id:      PropTypes.id
    version: PropTypes.number
  }, spec

PropTypes.Action = PropTypes.model {
  text:   PropTypes.text
  status: PropTypes.enum(ActionStatus)
  owner:  PropTypes.id
}

PropTypes.Card = PropTypes.model {
  title: PropTypes.string
  body:  PropTypes.string
  stack: PropTypes.id
  owner: PropTypes.id
}

PropTypes.Kind = PropTypes.model {
  name:   PropTypes.string
  color:  PropTypes.string
  stages: PropTypes.idArray
}

PropTypes.Stack = PropTypes.model {
  name:  PropTypes.string
  cards: PropTypes.idArray
}

PropTypes.Stage = PropTypes.model {
  name: PropTypes.string
}

PropTypes.Team = PropTypes.model {
  name:    PropTypes.string
  members: PropTypes.idArray
  stacks:  PropTypes.idArray
}

PropTypes.User = PropTypes.model {
  name:      PropTypes.string
  avatarUrl: PropTypes.string
}

module.exports = PropTypes
