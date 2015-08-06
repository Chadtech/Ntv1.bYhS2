_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect


tonic = 20


tones = [
  1
  1.143
  1.333
  1.556
  1.778
]

inharmonicity = 1.01

octaves = [0 .. 8]
octaves = _.map octaves, (octave) ->
  _.map tones, (tone, toneIndex) ->
    output = tonic * (2 ** octave) * tone
    output *= inharmonicity ** ((toneIndex + (octave * tones.length)) // tones.length)
    output

console.log octaves


octaves = _.map octaves, (octave, octaveIndex) ->
  _.map octave, (tone, toneIndex) ->

    sound = gen.sine
      amplitude: 0.5
      tone:      tone * 6.7
      sustain:   (5 * 44100)
    sound = eff.vol sound, factor: 0.5

    nextSound = gen.sine
      amplitude: 0.09
      tone:      tone * 6.58
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.11
      tone:      tone * 6.66
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    sound = eff.vol sound, factor: 0.333



    nextSound = gen.sine
      amplitude: 0.23
      tone:      tone * 5.3
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0

    nextSound = gen.sine
      amplitude: 0.08
      tone:      tone * 5.37
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.12
      tone:      tone * 5.34
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.07
      tone:      tone * 5.385
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.13
      tone:      tone * 5.325
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    sound = eff.vol sound, factor: 0.15




    sound = eff.fadeOut sound
    # sound = eff.fadeOut sound



    nextSound = gen.sine
      amplitude: 0.3
      tone:      tone * 4.1
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.08
      tone:      tone * 4.37
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.12
      tone:      tone * 4.34
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    nextSound = gen.sine
      amplitude: 0.07
      tone:      tone * 4.385
      sustain:   (5 * 44100)
    sound = Nt.mix nextSound, sound, 0
    sound = eff.vol sound, factor: 0.15



    sound = eff.fadeOut sound
    sound = eff.vol sound, factor: 0.6



    nextSound = gen.sine
      amplitude: 0.3
      tone:      tone * 3
      sustain:   (5 * 44100)

    sound = Nt.mix nextSound, sound, 0
    sound = eff.fadeOut sound
    sound = eff.vol sound, factor: 0.7

    nextSound = gen.sine
      amplitude: 0.3
      tone:      tone * 2
      sustain:   (5 * 44100)

    sound = Nt.mix nextSound, sound, 0
    sound = eff.fadeOut sound
    sound = eff.vol sound, factor: 0.5

    nextSound = gen.sine
      amplitude: 0.3
      tone:      tone
      sustain:   (5 * 44100)

    sound = Nt.mix nextSound, sound, 0
    sound = eff.fadeOut sound
    sound = eff.vol sound, factor: 0.6

    nextSound = gen.sine
      amplitude: 0.3
      tone:      tone / 2
      sustain:   (5 * 44100)

    sound = Nt.mix nextSound, sound, 0

    sound = eff.fadeOut sound
    sound = eff.fadeOut sound

    sound = eff.fadeIn sound, endAt: 60

    strike = gen.square
      amplitude:     1
      tone:          tone/3
      sustain:       120
      harmonicCount: 8

    strike = eff.ramp strike



    sound = Nt.join strike, sound

    fileName = 'bellA'
    fileName += octaveIndex 
    fileName += toneIndex 
    fileName += '.wav'
    
    sound = Nt.convertTo64Bit sound
    Nt.buildFile fileName, [ sound ]

    console.log tone

    0

