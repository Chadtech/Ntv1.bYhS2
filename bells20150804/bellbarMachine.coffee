###

  bar
    melody
    lines
    voices
    barStart
    beatLength

###

_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect


module.exports = (bar) ->

  melodies      = bar.melodies
  lines         = bar.lines
  voices        = bar.voices
  barStart      = bar.barStart
  beatDuration  = bar.beatDuration

  output = _.map lines, (line, lineIndex) =>

    melody = melodies[ lineIndex ]

    _.forEach melody, (melodyItem, melodyIndex) ->

      if melodyItem isnt ''

        moment = melodyIndex
        moment *= beatDuration
        moment += barStart
        moment += 1200 * Math.random()
        moment = moment // 1

        line = Nt.mix voices[ lineIndex ][ melodyItem ], line, moment

    line

  output

