React            = require 'react'
{cloneWithProps} = React.addons

module.exports = autokey = (items...) ->
  _.map _.compact _.flatten(items), (item, index) ->
    cloneWithProps item, {key: index}
