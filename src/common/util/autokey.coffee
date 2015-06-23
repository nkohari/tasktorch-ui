React            = require 'react/addons'
{cloneWithProps} = React.addons

module.exports = autokey = (items...) ->
  _.map _.compact _.flatten(items), (item, index) ->
    cloneWithProps item, {key: index}
