define [], () ->
  class WeaponRepository
    constructor: (@weapons) ->
    getWeapon: () -> @weapons[0]
  return WeaponRepository
