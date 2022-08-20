# Voice Recognition

The purpose of this project was to design an intelligent system speech recognition using artificial neural networks. Due to the high complexity of the problem posed was limited to recognizing only selected vowels (a, e, i) and words (open the door, close the door, turn on the light, turn off the light). The efficiency of recognizing vowels should be equal to at least 95% while word recognition efficiency should be at least 95%.

## Scope of work

The scope of work included:
- Obtaining an adequate number of samples for analysis: 90 samples for vowels at which
each vowel was spoken at three different speeds, and 40 samples
for commands, with each spoken at the same rate.
- Processing of the acquired samples, calculation of characteristic parameters
in the time domain and frequency domain.
- Normalization of the determined parameters and formation of the learning vector of the network
Neural network.
- Learning the neural network.
- Testing of the network and verification of recognition performance.

## Acquisition of audio samples

The voice samples were downloaded using Audacity software and exported to .wav extension files using "Signed 24-bit PCM." Recorded were mono sounds at 44100 Hz.

## Analysis of input signals 

To analyze the recorded voices, 4 parameters were used to determine the the obtained signal:

- average frequency
- harmonic ratio
- signal variance
- signal standard deviation

## Feed-forward neural network

A feed-forward neural network is a type of neural network in which the connections of units do not move in a loop, but rather in a single directed path. This differs from a recurrent neural network, in which information can move forward and backward throughout the system. A feedback neural network is probably the most common type of neural network because it is one of the easiest to understand and configure. These types of neural networks are used in data mining and other areas of research where predictive behavior is required.





