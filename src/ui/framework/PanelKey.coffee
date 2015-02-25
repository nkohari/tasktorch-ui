PanelKey = {}

PanelKey.forCard = (id) -> "c:#{id}"
PanelKey.forStack = (id) -> "s:#{id}"
PanelKey.forFollowing = -> 'f'

PanelKey.parse = (key) ->
  [prefix, id] = key.split(':')
  switch prefix
    when 'c' then type = 'card'
    when 's' then type = 'stack'
    when 'f' then type = 'following'
  return {type, id}

module.exports = PanelKey