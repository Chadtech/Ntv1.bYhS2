package main

import (
    // "bufio"
    "fmt"
    // "io"
    // "io/ioutil"
    // "strconv"
    "os"
    // "math"
)


func check(e error){
  if e != nil {
    panic(e)
  }
}

func convolver( audio []int, convolveSeed []int) []int {

  lengthOfOutput := int64(len(audio) + len(convolveSeed))
  output := make( []int, lengthOfOutput )

  for outputIndex := int64(0); outputIndex < lengthOfOutput; outputIndex++ {
    output[ outputIndex ] = 0
  }

  for convolveIndex := int64(0); convolveIndex < int64(len(convolveSeed)); convolveIndex++ {
    for audioIndex := int64(0); audioIndex < int64(len(audio)); audioIndex++ {

      atConvolve := convolveSeed[ convolveIndex ]
      if atConvolve > 32768 {
        atConvolve -= 65536
      }

      factor := (float32(atConvolve) / 32767)

      output[ convolveIndex + audioIndex ] += int(float32(audio[ audioIndex ]) * factor)

    }
  }

  return output

}



func readStereoWAV( openFileName string ) [][]int{

  readFile, err := os.Open( openFileName )
  check(err)
  readFile.Seek(40, 0)

  var sizeOfAudioBuffer int64 = 0
  durationByte                := make([]byte, 4)

  readFile.Read( durationByte )

  sizeOfAudioBuffer += int64(durationByte[0])
  sizeOfAudioBuffer += 256 * int64(durationByte[1])
  sizeOfAudioBuffer += 65536 * int64(durationByte[2])
  sizeOfAudioBuffer += 16777216 * int64(durationByte[3])
  durationOfAudio   := int64(sizeOfAudioBuffer / 2)

  output := make([][]int, 2 )
  output[0] = make([]int, durationOfAudio)
  output[1] = make([]int, durationOfAudio)

  for datumIndex := int64(0); datumIndex < (durationOfAudio); datumIndex++ {


      thisSampleByte := make([]byte, 2)
      readFile.Read( thisSampleByte )

      output[0][ datumIndex / 2 ] = 0
      output[0][ datumIndex / 2 ] += int(thisSampleByte[ 0 ])
      output[0][ datumIndex / 2 ] += int(thisSampleByte[ 1 ]) * 256
  

      thisSampleByte = make([]byte, 2)
      readFile.Read( thisSampleByte )

      output[1][ datumIndex / 2 ] = 0
      output[1][ datumIndex / 2 ] += int(thisSampleByte[ 0 ])
      output[1][ datumIndex / 2 ] += int(thisSampleByte[ 1 ]) * 256

  }

  return output

}

func readMonoWAV( openFileName string ) []int{

  readFile, err := os.Open( openFileName )
  check(err)
  readFile.Seek(40, 0)

  var sizeOfAudioBuffer int64 = 0
  durationByte                := make([]byte, 4)

  readFile.Read( durationByte )

  sizeOfAudioBuffer += int64(durationByte[0])
  sizeOfAudioBuffer += 256 * int64(durationByte[1])
  sizeOfAudioBuffer += 65536 * int64(durationByte[2])
  sizeOfAudioBuffer += 16777216 * int64(durationByte[3])
  durationOfAudio   := int64(sizeOfAudioBuffer / 2)

  output := make([]int, durationOfAudio)

  for datumIndex := int64(0); datumIndex < (durationOfAudio); datumIndex++ {

    thisSampleByte := make([]byte, 2)
    readFile.Read( thisSampleByte )

    output[ datumIndex ] = 0
    output[ datumIndex ] += int(thisSampleByte[ 0 ])
    output[ datumIndex ] += int(thisSampleByte[ 1 ]) * 256
  
  }

  return output

}


func main() {

  wavFile      := readStereoWAV( os.Args[1] )
  convolveSeed := readMonoWAV( os.Args[2] )


  wavFile[0] = convolver( wavFile[0], convolveSeed )
  wavFile[1] = convolver( wavFile[1], convolveSeed )

  fmt.Println(os.Args[1])

  // savedFile, err := os.Create( os.Args[1] + "_CONVOLVEDw_" + os.Args[2] )
  // check(err)

  // wavHeader := make([]byte, 44)

  // wavHeader[0] = 82
  // wavHeader[1] = 73
  // wavHeader[2] = 70
  // wavHeader[3] = 70

  // wavHeader[4] = 36
  // wavHeader[5] = 8
  // wavHeader[6] = 0
  // wavHeader[7] = 0

  // wavHeader[8]  = 87
  // wavHeader[9]  = 65
  // wavHeader[10] = 86
  // wavHeader[11] = 69

  // wavHeader[12] = 102
  // wavHeader[13] = 109
  // wavHeader[14] = 116
  // wavHeader[15] = 32
 
  // wavHeader[16] = 16
  // wavHeader[17] = 0
  // wavHeader[18] = 0
  // wavHeader[19] = 0

  // wavHeader[20] = 1
  // wavHeader[21] = 0
  // wavHeader[22] = 2
  // wavHeader[23] = 0

  // wavHeader[24] = 68
  // wavHeader[25] = 172
  // wavHeader[26] = 0
  // wavHeader[27] = 0

  // wavHeader[28] = 68
  // wavHeader[29] = 172
  // wavHeader[30] = 0
  // wavHeader[31] = 0

  // wavHeader[32] = 4
  // wavHeader[33] = 0
  // wavHeader[34] = 16
  // wavHeader[35] = 0

  // wavHeader[36] = 100
  // wavHeader[37] = 97
  // wavHeader[38] = 116
  // wavHeader[39] = 97

  // wavHeader[40] = byte(len(pieceL) % 256)
  // wavHeader[41] = byte(len(pieceL) / 256)
  // wavHeader[42] = byte(len(pieceL) / 4096)
  // wavHeader[43] = byte(len(pieceL) / 65536)

  // wavData := make([]byte, (len(pieceL)) * 2)

  // for audioIndex := 0; audioIndex < len(pieceL); audioIndex++ {

  //   wavData[  audioIndex * 2      ] = byte(pieceL[ audioIndex ] % 256)
  //   wavData[ (audioIndex * 2) + 1 ] = byte(pieceL[ audioIndex ] / 256)

  // }

  // savedFile.Write(wavHeader)
  // savedFile.Write(wavData)

  // savedFile.Close()


}




