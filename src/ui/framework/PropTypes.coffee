_            = require 'lodash'
React        = require 'react'
ActionStatus = require 'data/enums/ActionStatus'

PropTypes = _.extend {}, React.PropTypes

PropTypes.id      = PropTypes.string
PropTypes.idArray = PropTypes.arrayOf(PropTypes.id)
PropTypes.enum    = (hash) -> PropTypes.oneOf _.values(hash)

PropTypes.model = (spec) ->
  PropTypes.shape _.extend {
    id:      PropTypes.id
    version: PropTypes.number
  }, spec

# TODO: We should combine these with the model definitions somehow.

PropTypes.Action = PropTypes.model {
  org:    PropTypes.id
  text:   PropTypes.text
  status: PropTypes.enum(ActionStatus)
  user:   PropTypes.id
}

PropTypes.Card = PropTypes.model {
  org:     PropTypes.id
  title:   PropTypes.string
  summary: PropTypes.string
  stack:   PropTypes.id
  user:    PropTypes.id
  team:    PropTypes.id
  kind:    PropTypes.id
  number:  PropTypes.number
}

PropTypes.Checklist = PropTypes.model {
  card:  PropTypes.id
  org:   PropTypes.id
  stage: PropTypes.id
}

PropTypes.File = PropTypes.model {
  org:  PropTypes.id
  name: PropTypes.string
  type: PropTypes.string
  size: PropTypes.number
  url:  PropTypes.string
}

PropTypes.Goal = PropTypes.model {
  org:  PropTypes.id
  name: PropTypes.string
}

PropTypes.Kind = PropTypes.model {
  org:    PropTypes.id
  name:   PropTypes.string
  color:  PropTypes.string
  stages: PropTypes.idArray
}

PropTypes.Membership = PropTypes.model {
  org:  PropTypes.id
  user: PropTypes.id
}

PropTypes.Note = PropTypes.model {
  org:  PropTypes.id
  type: PropTypes.string
  user: PropTypes.id
  card: PropTypes.id
}

PropTypes.Org = PropTypes.model {
  name:    PropTypes.string
  leaders: PropTypes.idArray
  members: PropTypes.idArray
}

PropTypes.Profile = PropTypes.model {
  title:    PropTypes.string
  bio:      PropTypes.string
  contacts: PropTypes.arrayOf(PropTypes.object)
}

PropTypes.Stack = PropTypes.model {
  org:   PropTypes.id
  name:  PropTypes.string
  cards: PropTypes.idArray
}

PropTypes.Stage = PropTypes.model {
  name: PropTypes.string
}

PropTypes.Team = PropTypes.model {
  org:     PropTypes.id
  name:    PropTypes.string
  members: PropTypes.idArray
  stacks:  PropTypes.idArray
}

PropTypes.User = PropTypes.model {
  name:      PropTypes.string
  email:     PropTypes.string
  avatarUrl: PropTypes.string
}

module.exports = PropTypes
