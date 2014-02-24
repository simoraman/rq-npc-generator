define [], () ->
  class ArmorRepository
    constructor: (@armors) ->
  getArmor: () -> @armors[0]
  return ArmorRepository
