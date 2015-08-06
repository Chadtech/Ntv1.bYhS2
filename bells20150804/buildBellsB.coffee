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
bellDuration = 44100 * 4

octaves = [0 .. 8]
octaves = _.map octaves, (octave) ->
  _.map tones, (tone, toneIndex) ->
    output = tonic * (2 ** octave) * tone
    output *= inharmonicity ** ((toneIndex + (octave * tones.length)) // tones.length)
    output


octaves = _.map octaves, (octave, octaveIndex) ->
  _.map octave, (tone, toneIndex) ->

    sounds = []

    fundamental = gen.sine
      amplitude: 0.5
      tone:      tone
      sustain:   bellDuration * 0.6
    sounds.push fundamental


    firstHarmonic = gen.sine
      amplitude: 0.25
      tone:      tone * 2
      sustain:   bellDuration * 0.45
    sounds.push firstHarmonic


    subHarmonic = gen.sine
      amplitude: 0.25
      tone:      tone / 2
      sustain:   bellDuration
    sounds.push subHarmonic


    secondHarmonic = gen.sine
      amplitude: 0.125
      tone:      tone * 3
      sustain:   bellDuration * 0.4
    sounds.push secondHarmonic


    thirdHarmonic = gen.sine
      amplitude: 0.0625
      tone:      tone * 4.26
      sustain:   bellDuration * 0.38
    sounds.push thirdHarmonic

    
    fourthHarmonic = gen.sine
      amplitude: 0.03125
      tone:      tone * 5.55
      sustain:   bellDuration * 0.32
    sounds.push fourthHarmonic


    fifthHarmonic = gen.sine
      amplitude: 0.015625
      tone:      tone * 7.02
      sustain:   bellDuration * 0.3
    sounds.push fifthHarmonic

    sounds = _.map sounds, (sound) ->
      eff.vol (eff.fadeOut sound), factor: 0.7

    enharmonics = [
      {relativePitch: 0.6, volume: 0.09, duration: 0.1}
      {relativePitch: 1.5, volume: 0.05, duration: 0.11}
      {relativePitch: 1.6, volume: 0.04, duration: 0.12}
      {relativePitch: 2.2, volume: 0.04, duration: 0.13}
      {relativePitch: 3.8, volume: 0.04, duration: 0.06}
      {relativePitch: 4.0, volume: 0.05, duration: 0.04}
      {relativePitch: 4.9, volume: 0.04, duration: 0.07}
      {relativePitch: 5.1, volume: 0.03, duration: 0.08}
      {relativePitch: 5.6, volume: 0.05, duration: 0.04}
      {relativePitch: 5.7, volume: 0.04, duration: 0.07}
      {relativePitch: 5.8, volume: 0.03, duration: 0.08}
      {relativePitch: 6.6, volume: 0.03, duration: 0.03}
      {relativePitch: 7.4, volume: 0.03, duration: 0.03}
      {relativePitch: 7.7, volume: 0.02, duration: 0.03}
    ]

    enharmonics = _.map enharmonics, (enharmonic) ->
      gen.sine 
        amplitude: enharmonic.volume
        tone:      tone * enharmonic.relativePitch
        sustain:   enharmonic.duration


    sounds = sounds.concat enharmonics
    sounds.unshift (gen.silence sustain: bellDuration)

    output = _.reduce sounds, (mix, sound) ->
      Nt.mix sound, mix, 0

    output = eff.ramp output

    fileName = 'bellB'
    fileName += octaveIndex 
    fileName += toneIndex 
    fileName += '.wav'
    
    output = Nt.convertTo64Bit output
    Nt.buildFile fileName, [ output ]

    console.log tone

    0

