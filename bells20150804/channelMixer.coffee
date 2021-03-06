_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect

module.exports = (channels, line, mix, delays) ->

  mixedLines = [
    eff.vol line, factor: mix[0]
    eff.vol line, factor: mix[1]
  ]

  mixedLines = _.map mixedLines, (mixedLine, mixedLineIndex) ->
    eff.shift mixedLine, shift: delays[mixedLineIndex]

  channels[0] = Nt.mix mixedLines[0], channels[0] 
  channels[1] = Nt.mix mixedLines[1], channels[1]

  channels