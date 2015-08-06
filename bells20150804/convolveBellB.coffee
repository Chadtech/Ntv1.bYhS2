_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect

bellB = Nt.open 'bellBExample.wav'

bellB = _.map bellB, (channel) ->
  Nt.convertToFloat channel

console.log '9'

convolveSeed = (Nt.open 'momentOfCartel.wav')[0]
convolveSeed = Nt.convertToFloat convolveSeed

console.log 'A'

bellB = _.map bellB, (channel) ->
  console.log 'A.1'
  eff.convolve channel, 
    seed: convolveSeed

console.log 'B'

bellB = _.map bellB, (channel) ->
  Nt.convertTo64Bit channel


console.log 'C'

Nt.buildFile 'convolvedBellBExample.wav', bellB
