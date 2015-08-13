_   = require 'lodash'
Nt  = require './noitech.coffee'
gen = Nt.generate
eff = Nt.effect


bellBar = require './bellbarMachine.coffee'

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
  '14': octavesOfBellB[1][4]
  '20': octavesOfBellB[2][0]
  '21': octavesOfBellB[2][1]
  '22': octavesOfBellB[2][2]

voice1 =
  '14': octavesOfBellB[1][4]
  '20': octavesOfBellB[2][0]
  '21': octavesOfBellB[2][1]
  '22': octavesOfBellB[2][2]

voice2 = 
  '24': octavesOfBellB[2][4]
  '30': octavesOfBellB[3][0]
  '31': octavesOfBellB[3][1]
  '32': octavesOfBellB[3][2]
  '33': octavesOfBellB[3][3]
  '34': octavesOfBellB[3][4]
  '40': octavesOfBellB[4][0]

voice3 = 
  '24': octavesOfBellB[2][4]
  '30': octavesOfBellB[3][0]
  '31': octavesOfBellB[3][1]
  '32': octavesOfBellB[3][2]
  '33': octavesOfBellB[3][3]
  '34': octavesOfBellB[3][4]
  '40': octavesOfBellB[4][0]

voice4 = 
  '42': octavesOfBellB[4][2]
  '43': octavesOfBellB[4][3]
  '44': octavesOfBellB[4][4]
  '50': octavesOfBellB[5][0]

voice5 = 
  '42': octavesOfBellB[4][2]
  '43': octavesOfBellB[4][3]
  '44': octavesOfBellB[4][4]
  '50': octavesOfBellB[5][0]

voices =
  0: voice0
  1: voice1
  2: voice2
  3: voice3
  4: voice4
  5: voice5


beatDuration = 20100
beat         = 0
lines        = []

for time in [0 .. 5] by 1
  lines.push gen.silence sustain: (beatDuration * 128)



lines = bellBar
  melodies: [
    [ 'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X' ]
    [ 'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X' ]
    [ '30', '31', 'X',  '30', '31', '32', '30', '31', 'X' ]
    [ '30', '31', 'X',  '30', '31', '32', '30', '31', 'X' ]
    [ 'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X' ]
    [ 'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X',  'X' ]
  ]
  lines:        lines
  voices:       voices
  barStart:     1000
  beatDuration: beatDuration




channels = []
_.times 2, ->
  channels.push gen.silence sustain: (beatDuration * 128)

console.log 'Mix to Channels'

channels[0] = Nt.mix lines[0], channels[0]
channels[0] = Nt.mix lines[2], channels[0]
channels[0] = Nt.mix lines[4], channels[0]
channels[1] = Nt.mix lines[1], channels[1]
channels[1] = Nt.mix lines[3], channels[1]
channels[1] = Nt.mix lines[5], channels[1]


console.log 'Build File'

Nt.buildFile 'bellSong0P1.wav', [ channels[0], channels[1] ]





