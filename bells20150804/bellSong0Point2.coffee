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
  
  thisOctave.push thisBellSound

  if (bellIndex % 5) is 4
    octavesOfBellB.push thisOctave

    thisOctave = []

console.log 'Assigning Voices'


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


console.log 'Make timings'
beatDuration  = 20100
timings       = [ 0 ]
_.times 128, (time) =>
  nextTime      =  Math.random() / 20
  nextTime      += 0.975
  nextTime      *= beatDuration
  beatDuration  = nextTime // 1

  timings.push (timings[ time ] + beatDuration )

allTimings = []
_.times 6, ->
  anotherTiming = _.map timings, (timing) ->
    (timing + (Math.random() * 5000) - 2500) // 1
  allTimings.push anotherTiming


# bar   = 0
lines = []
for time in [0 .. 5] by 1
  lines.push gen.silence sustain: (beatDuration * 256)





part0 = require './0p2Part1.coffee'
lines = part0 lines, allTimings, voices, bellBar




channels = []
_.times 2, =>
  channels.push gen.silence sustain: (beatDuration * 256 )

console.log 'Mix to Channels'

channels[0] = Nt.mix lines[0], channels[0]
channels[0] = Nt.mix lines[2], channels[0]
channels[0] = Nt.mix lines[4], channels[0]
channels[1] = Nt.mix lines[1], channels[1]
channels[1] = Nt.mix lines[3], channels[1]
channels[1] = Nt.mix lines[5], channels[1]

# channels = channelMixer channels, lines[0], [ 0.9 , 0.2 ], [0, 0.025]
# channels = channelMixer channels, lines[1], [ 0.5, 0.65 ], [0.01, 0]

# channels = channelMixer channels, lines[2], [ 0.7,  0.3 ], [0, 0.15]
# channels = channelMixer channels, lines[3], [ 0.3,  0.7 ], [0.15, 0]

# channels = channelMixer channels, lines[4], [ 0.2,  0.9 ], [0.025, 0]
# channels = channelMixer channels, lines[5], [ 0.65, 0.5 ], [0, 0.01]


console.log 'Channels to 64 bit'

channels = _.map channels, (channel) ->
  Nt.convertTo64Bit (eff.vol channel, factor: 0.7)


console.log 'Build File'

Nt.buildFile 'bellSong0P2.wav', [ channels[0], channels[1] ]





