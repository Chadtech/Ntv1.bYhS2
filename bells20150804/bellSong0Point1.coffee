_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect


bellBar       = require './bellbarMachine.coffee'
channelMixer  = require './channelMixer.coffee'


octavesOfBellB = []
thisOctave     = []
console.log 'Loading Bells'
for bellIndex in [0 .. 44 ]

  bellNumber = bellIndex % 5
  bellNumber += ''
  bellNumber = (bellIndex // 5) + bellNumber

  filePath = './bellB/bellB' + bellNumber
  filePath += '.wav'

  thisBellSound = Nt.open filePath
  thisBellSound = Nt.convertToFloat thisBellSound[0]
  thisBellSound = eff.vol thisBellSound, factor: 0.3
  # thisBellSound = eff.ramp thisBellSound
  
  thisOctave.push thisBellSound

  if (bellIndex % 5) is 4
    octavesOfBellB.push thisOctave

    thisOctave = []

console.log 'Finished loading bells'




voice0 =
  '14': octavesOfBellB[2][4]
  '20': octavesOfBellB[3][0]
  '21': octavesOfBellB[3][1]
  '22': octavesOfBellB[3][2]

voice1 =
  '14': octavesOfBellB[2][4]
  '20': octavesOfBellB[3][0]
  '21': octavesOfBellB[3][1]
  '22': octavesOfBellB[3][2]

voice2 = 
  '24': octavesOfBellB[3][4]
  '30': octavesOfBellB[4][0]
  '31': octavesOfBellB[4][1]
  '32': octavesOfBellB[4][2]
  '33': octavesOfBellB[4][3]
  '34': octavesOfBellB[4][4]
  '40': octavesOfBellB[5][0]

voice3 = 
  '24': octavesOfBellB[3][4]
  '30': octavesOfBellB[4][0]
  '31': octavesOfBellB[4][1]
  '32': octavesOfBellB[4][2]
  '33': octavesOfBellB[4][3]
  '34': octavesOfBellB[4][4]
  '40': octavesOfBellB[5][0]

voice4 = 
  '42': octavesOfBellB[5][2]
  '43': octavesOfBellB[5][3]
  '44': octavesOfBellB[5][4]
  '50': octavesOfBellB[6][0]

voice5 = 
  '42': octavesOfBellB[5][2]
  '43': octavesOfBellB[5][3]
  '44': octavesOfBellB[5][4]
  '50': octavesOfBellB[6][0]

voices =
  0: voice0
  1: voice1
  2: voice2
  3: voice3
  4: voice4
  5: voice5


beatDuration = 20100
bar          = 0
lines        = []

for time in [0 .. 5] by 1
  lines.push gen.silence sustain: (beatDuration * 256)

console.log 'BAR 0'
bar++
lines = bellBar
  melodies: [
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '31', '',  '30', '31', '32', '30', '31', '30' ]
    [ '31', '',  '30', '31', '32', '30', '31', '30' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 1'
bar++
lines = bellBar
  melodies: [
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '31', '',  '30', '31', '32', '30', '32', '30' ]
    [ '31', '',  '30', '31', '32', '30', '32', '30' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 2'
bar++
lines = bellBar
  melodies: [
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
    [ '31', '',  '30', '31', '32', '30', '31', '30' ]
    [ '' ,  '31', '',  '30', '31', '32', '30', '31' ]
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration





console.log 'BAR 3'
lines = bellBar
  melodies: [
    [ '21',   '',   '',  '',   '',   '',   '',   '' ]
    [ '21',   '',   '',  '',   '',   '',   '',   '' ]
    [ '31', '',  '30', '31', '32', '30', '31', '30' ]
    [ '31', '',  '30', '31', '32', '30', '31', '30' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 4'
bar++
lines = bellBar
  melodies: [
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '31', '',  '30', '31', '32', '30', '32', '30' ]
    [ '31', '',  '30', '31', '32', '30', '32', '30' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
    [ '',   '',   '',  '',   '',   '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 5'
bar++
lines = bellBar
  melodies: [
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
    [ '31', '',  '30', '31', '32', '30', '31', '30' ]
    [ '' ,  '31', '',  '30', '31', '32', '30', '31' ]
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
    [ '',   '',   '',   '',   '',   '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration











console.log 'BAR 6'
bar++
lines = bellBar
  melodies: [
    [ '20',  '',  '22',  '',  '',  '21',  '20',  '' ]
    [ '20',  '',  '22',  '',  '',  '21',  '20',  '' ]
    [ '30',  '',  '',    '',  '',  '',    '',  '' ]
    [ '30',  '',  '',    '',  '',  '',    '',  '' ]
    [ '',    '',  '',    '',  '',  '',    '',  '' ]
    [ '',    '',  '',    '',  '',  '',    '',  '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR 7'
bar++
lines = bellBar
  melodies: [
    [ '20',  '',  '', '20',  '22',  '',  '',  '21' ]
    [ '20',  '',  '', '20',  '22',  '',  '',  '21' ]
    [ '32',    '',  '', '',  '',  '',    '',  '' ]
    [ '32',    '',  '', '',  '',  '',    '',  '' ]
    [ '',    '',  '', '',  '',  '',    '',  '' ]
    [ '',    '',  '', '',  '',  '',    '',  '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR 8'
bar++
lines = bellBar
  melodies: [
    [ '20',  '',  '',  '22',  '21',  '',  '22',  '' ]
    [ '20',  '',  '',  '22',  '21',  '',  '22',  '' ]
    [ '30',  '',  '',    '',  '',  '',    '',  '' ]
    [ '30',  '',  '',    '',  '',  '',    '',  '' ]
    [ '',    '',  '',    '',  '',  '',    '',  '' ]
    [ '',    '',  '',    '',  '',  '',    '',  '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR 9'
bar++
lines = bellBar
  melodies: [
    [ '20',  '',  '22',  '',  '',  '21',  '20',  '' ]
    [ '20',  '',  '22',  '',  '',  '21',  '20',  '' ]
    [ '30',  '',  '',    '',  '',  '',    '',    '' ]
    [ '30',  '',  '',    '',  '',  '',    '',    '' ]
    [ '',    '',  '',    '',  '',  '',    '',    '' ]
    [ '',    '',  '',    '',  '',  '',    '',    '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR A'
bar++
lines = bellBar
  melodies: [
    [ '20',    '',  '', '20',  '22',  '',  '',  '21' ]
    [ '20',    '',  '', '20',  '22',  '',  '',  '21' ]
    [ '32',    '',  '', '',    '',    '',  '',  '' ]
    [ '32',    '',  '', '',    '',    '',  '',  '' ]
    [ '',      '',  '', '',    '',    '',  '',  '' ]
    [ '',      '',  '', '',    '',    '',  '',  '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR B'
bar++
lines = bellBar
  melodies: [
    [ '20',  '',  '22',  '',  '',  '21',  '20',  '' ]
    [ '20',  '',  '22',  '',  '',  '21',  '20',  '' ]
    [ '30',  '',  '',    '',  '',  '',    '',    '' ]
    [ '30',  '',  '',    '',  '',  '',    '',    '' ]
    [ '',    '',  '',    '',  '',  '',    '',    '' ]
    [ '',    '',  '',    '',  '',  '',    '',    '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration








console.log 'BAR C'
bar++
lines = bellBar
  melodies: [
    [ '20', '', '',   '',   '',   '',   '',   '' ]
    [ '20', '', '',   '',   '',   '',   '',   '' ]
    [ '30', '', '',   '',   '',   '',   '',   '' ]
    [ '30', '', '',   '',   '',   '',   '',   '' ]
    [ '',   '', '',   '42', '',   '43', '44', '50' ]
    [ '',   '', '42', '',   '43', '',   '42', '43' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR D'
bar++
lines = bellBar
  melodies: [
    [ '22', '',   '',   '',   '',   '',   '21', '' ]
    [ '22', '',   '',   '',   '',   '',   '21', '' ]
    [ '32', '',   '',   '',   '',   '',   '31', '' ]
    [ '32', '',   '',   '',   '',   '',   '31', '' ]
    [ '',   '43', '50', '43', '44', '50', '',   '' ]
    [ '',   '43', '50', '43', '44', '50', '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR E'
bar++
lines = bellBar
  melodies: [
    [ '20', '',   '',   '20', '',   '',   '22', '' ]
    [ '20', '',   '',   '22', '',   '',   '22', '' ]
    [ '30', '',   '',   '30', '',   '',   '32', '' ]
    [ '30', '',   '',   '32', '',   '',   '32', '' ]
    [ '50', '44', '43', '42', '44', '43', '42', '' ]
    [ '50', '',   '44', '',   '43', '',   '42', '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR F'
bar++
lines = bellBar
  melodies: [
    [ '20', '',   '',   '20', '',   '',   '20', '' ]
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '30', '',   '',   '30', '',   '',   '30', '' ]
    [ '30', '',   '',   '32', '',   '',   '30', '' ]
    [ '50', '44', '43', '42', '44', '43', '44', '' ]
    [ '50', '',   '44', '',   '43', '',   '44', '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR 10'
bar++
lines = bellBar
  melodies: [
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '30', '31', '',   '30', '31', '32', '30', '31' ]
    [ '30', '31', '',   '30', '31', '32', '30', '31' ]
    [ '50', '',   '42', '',   '43', '',   '43', '' ]
    [ '50', '',   '42', '',   '43', '',   '43', '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 11'
bar++
lines = bellBar
  melodies: [
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '30', '31', '',   '30', '31', '32', '30', '32' ]
    [ '30', '31', '',   '30', '31', '32', '30', '32' ]
    [ '50', '',   '43', '',   '43', '',   '42', '' ]
    [ '50', '',   '43', '',   '43', '',   '42', '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 12'
bar++
lines = bellBar
  melodies: [
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '20', '',   '',   '22', '',   '',   '20', '' ]
    [ '',   '30', '31', '32', '30', '32', '30', '31' ]
    [ '30', '31', '',   '30', '31', '32', '30', '32' ]
    [ '50', '',   '42', '',   '43', '',   '43', '' ]
    [ '50', '',   '42', '',   '43', '',   '43', '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 13'
bar++
lines = bellBar
  melodies: [
    [ '20', '',   '',   '22', '',   '14',   '20', '21' ]
    [ '20', '',   '',   '22', '',   '14',   '20', '21' ]
    [ '',   '30', '31', '32', '30', '32', '30', '31' ]
    [ '30', '31', '',   '30', '31', '32', '30', '31' ]
    [ '50', '',   '43', '',   '43', '',   '42', '' ]
    [ '50', '',   '43', '',   '43', '',   '42', '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 14'
bar++
lines = bellBar
  melodies: [
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 15'
bar++
lines = bellBar
  melodies: [
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '22', '21', '20', '22', '21', '20', '22', '21' ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR 16'
bar++
lines = bellBar
  melodies: [
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '20', '21', '20', '21', '22', '20', '21', '22' ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '',   '',   '',   ''   ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 17'
bar++
lines = bellBar
  melodies: [
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '',   '30',   '',   '',   '',   '',   '',   ''   ]
    [ '24', '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '44',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '50',   '',   '',   ''   ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration


console.log 'BAR 18'
bar++
lines = bellBar
  melodies: [
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '22', '21', '20', '22', '21', '20', '22', '21' ]
    [ '',   '31', '',   '',   '',   '',   '',   ''   ]
    [ '24', '',   '',   '',   '',   '',   '',   ''   ]
    [ '',   '',   '',   '44', '',   '',   '',   ''   ]
    [ '',   '',   '',   '',   '50', '',   '',   ''   ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration

console.log 'BAR 19'
bar++
lines = bellBar
  melodies: [
    [ '14', '20', '21', '14', '20', '14', '20', '21' ]
    [ '20', '21', '20', '21', '22', '20', '21', '22' ]
    [ '',   '31', '',   '',   '',   '',   '',   '' ]
    [ '24', '',   '',   '',   '',   '',   '',   '' ]
    [ '',   '',   '',   '44', '',   '',   '',   '' ]
    [ '',   '',   '',   '',   '50', '',   '',   '' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000 + (bar * 8 * beatDuration)
  beatDuration: beatDuration




channels = []
_.times 2, =>
  channels.push gen.silence sustain: (beatDuration * 256 )

console.log 'Mix to Channels'

# channels[0] = Nt.mix lines[0], channels[0]
# channels[0] = Nt.mix lines[2], channels[0]
# channels[0] = Nt.mix lines[4], channels[0]
# channels[1] = Nt.mix lines[1], channels[1]
# channels[1] = Nt.mix lines[3], channels[1]
# channels[1] = Nt.mix lines[5], channels[1]

channels = channelMixer channels, lines[0], [ 0.9 , 0.2 ], [0, 0.025]
channels = channelMixer channels, lines[1], [ 0.5, 0.65 ], [0.01, 0]

channels = channelMixer channels, lines[2], [ 0.7,  0.3 ], [0, 0.15]
channels = channelMixer channels, lines[3], [ 0.3,  0.7 ], [0.15, 0]

channels = channelMixer channels, lines[4], [ 0.2,  0.9 ], [0.025, 0]
channels = channelMixer channels, lines[5], [ 0.65, 0.5 ], [0, 0.01]



console.log 'Channels to 64 bit'

channels = _.map channels, (channel) ->
  Nt.convertTo64Bit (eff.vol channel, factor: 0.7)


console.log 'Build File'

Nt.buildFile 'bellSong0P1.wav', [ channels[0], channels[1] ]





