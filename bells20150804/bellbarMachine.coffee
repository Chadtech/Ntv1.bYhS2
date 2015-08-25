###

  bar
    melody
    lines
    timings
    voices
    barStart
    beatLength

###

_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect

rampRate = 60


module.exports = (bar) ->

  melodies      = bar.melodies
  lines         = bar.lines
  timings       = bar.timings
  voices        = bar.voices
  barNumber     = bar.barNumber

  output = _.map lines, (line, lineIndex) =>

    melody = melodies[ lineIndex ]
    timing = timings[ lineIndex ].slice (barNumber * 8), (barNumber * 8 ) + 9

    _.forEach melody, (melodyItem, melodyIndex) =>

      if melodyItem isnt ''

        thisMoment = timing[ melodyIndex ]
        nextMoment = timing[ melodyIndex + 1 ]

        durationOfNote = sustain: (nextMoment - thisMoment) * 7
        blockOfSilence = gen.silence durationOfNote
        blockOfLine    = line.slice thisMoment - rampRate, thisMoment
        blockOfSilence = blockOfLine.concat blockOfSilence
        blockOfSilence = eff.fadeOut blockOfSilence, (beginAt: 0, endAt: rampRate)

        line = Nt.displace blockOfSilence, line, thisMoment - rampRate
        line = Nt.mix voices[ lineIndex ][ melodyItem ], line, thisMoment

    line

  output


