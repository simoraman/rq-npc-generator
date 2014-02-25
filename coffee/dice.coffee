define () ->
  rollD = (d) ->
    if d == 0
      0
    else
      Math.floor(Math.random() * d + 1)
  return rollD
