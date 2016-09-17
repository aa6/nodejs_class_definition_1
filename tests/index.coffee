colors = require 'colors'
events = require 'events'
#niggershit = require 'app-cron-implementer'
class_alternative_implementation = require '../src/index.coffee'

test = (check_result,description) ->
  console.log(
    if check_result then "PASSED".green else "FAILED".red,
    description
  )

#
# A class: no prototype
#

A = class_alternative_implementation(

  A_obj =

    constructor: (@param1,@param2) ->
      console.log "constructorA"
    renderA: ->
      console.log "renderA"
      return [@]

)

#
# B class: prototype is a function
#

B = class_alternative_implementation(

  B_obj =
    prototype: A
    renderB: ->
      console.log "renderB"
      return [@]

)

#
# C class: prototype is another function
#

C = class_alternative_implementation(

  C_obj =
    prototype: events.EventEmitter
    renderC: ->
      console.log "renderC"
      return [@]

)

D = class_alternative_implementation

  prototype: A
  renderD: ->
    console.log "renderD"
    return [@]

E = class_alternative_implementation(

  E_obj =
    prototype: A
    constructor: (@param1e,@param2e) ->
      @prototype(@param1e,@param2e)
      console.log "constructorE"
    renderE: ->
      console.log "renderE"
      return [@]

)

a = new A()
aa = new A("param1_val_A","param2_val_A")

b = new B()
bb = new B("param1_val_B","param2_val_B")

c = new C()

d = D()
dd = D("param1_val_D","param2_val_D")

ee = E("param1_val_E","param2_val_E")
console.log ee

test(
  typeof A.prototype.prototype is 'undefined',
  """A.prototype.prototype should be undefined"""
)
test(
  A.prototype is A_obj,
  """A.prototype should be the A_obj"""
)
test(
  typeof a.prototype == "undefined",
  """a.prototype should be undefined"""
)
test(
  !a.hasOwnProperty("constructor") and
  a.constructor is A_obj.constructor,
  """a.[[__proto__]] should be the A_obj"""
)

test(
  B.prototype isnt B_obj,
  """B.prototype shouldn't be the B_obj because B.prototype should be 
  created by Object.create function and all properties of the B_obj
  should be copied onto this new object"""
)
test(
  B.prototype.prototype is A,
  """B.prototype.prototype should be A"""
)
test(
  B.prototype.prototype.prototype is A_obj,
  """B.prototype.prototype.prototype should be A_obj"""
)
test(
  typeof B.prototype.prototype.prototype.prototype is 'undefined',
  """B.prototype.prototype.prototype.prototype should be undefined"""
)
test(
  bb.param1 is "param1_val_B",
  """B has no constructor and A constructor should've been executed instead"""
)
test(
  b.renderA?,
  """b should inherit A.renderA function"""
)
test(
  b.renderB?,
  """b should inherit B.renderB function"""
)

test(
  C.prototype.prototype is events.EventEmitter,
  """C.prototype.prototype should be events.EventEmitter"""
)

# Folded version should also work

###
test(
  D.prototype isnt D_obj,
  """D.prototype shouldn't be the D_obj because D.prototype should be 
  created by Object.create function and all properties of the D_obj
  should be copied onto this new object"""
)
###
test(
  D.prototype.prototype is A,
  """D.prototype.prototype should be A"""
)
test(
  D.prototype.prototype.prototype is A_obj,
  """D.prototype.prototype.prototype should be A_obj"""
)
test(
  typeof D.prototype.prototype.prototype.prototype is 'undefined',
  """D.prototype.prototype.prototype.prototype should be undefined"""
)
test(
  dd.param1 is "param1_val_D",
  """D has no constructor and A constructor should've been executed instead"""
)
test(
  d.renderA?,
  """D should inherit A.renderA function"""
)
test(
  d.renderD?,
  """d should inherit D.renderD function"""
)