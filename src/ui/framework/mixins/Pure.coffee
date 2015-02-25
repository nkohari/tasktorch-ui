compare = require 'common/util/compare'

Pure = {

  shouldComponentUpdate: (newProps, newState) ->
    !compare.hashes(@props, newProps) or !compare.hashes(@state, newState)

}

module.exports = Pure
