class LocalStorageSlot

  constructor: (@slot) ->

  get: (name) ->
    value = localStorage.getItem(@_key(name))
    if value?
      JSON.parse(value)
    else
      undefined

  set: (name, value) ->
    localStorage.setItem(@_key(name), JSON.stringify(value))

  remove: (name) ->
    localStorage.removeItem(@_key(name))

  _key: (name) ->
    "#{@slot}.#{name}"

LocalStorage = {

  getStorageSlot: (slot) ->
    new LocalStorageSlot(slot)

}

module.exports = LocalStorage
