module.exports = (obj) ->
  return (-> __class = (-> __args = Array.prototype.slice.call(arguments); if @ instanceof __class then (__class.prototype.constructor?.apply(@,__args) if __class isnt __class.prototype.constructor);@ else new (Function.prototype.bind.apply(__class,[null].concat(__args)))); (__class.prototype = if typeof @prototype is 'function' then Object.create(@prototype.prototype) else if @prototype? then @prototype else @); __class.prototype[__prop] = @[__prop] for __prop of @ unless __class.prototype is @; __class).apply obj