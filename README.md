# Project_Finger_Water Ver 1_0
The following final project thesis is the set of applications for an audio recognition and second screen system via digital audio fingerprinting and watermarking techniques.The work is based on the following papers:

Avery Li-chun Wang; "An Industrial-Strength Audio Search Algorithm" ,2003.    

Ingemar J. Cox, Senior Member, IEEE, Joe Kilian, F. Thomson Leighton, and Talal Shamoon, Member, IEEE ;Secure Spread Spectrum Watermarking for Multimedia,1997.

Code implementation is based on the following sites: https://github.com/israkir/cox-watermarking and https://www.princeton.edu/~cuff/ele201/labs.html

# What is necessary
This project is fully develop in Matlab and should work both in windows/mac operating systems.However it's important that:

-The Matlab version is at least R2017a or higher as it supports the use of simulink for program all android devices.

-Install the Simulink Support Package for Android Devices: Search in matlab on the Add Ons option for it.

# Explanation of the prototype system 

A database of songs is created for identify a piece of track that may match with one of the songs of this database.This is inside  a server-first device.

It's determined the song that fits best the fingerprint features of the clip and proceed to be encoded a watermark sequence via a secret key.

A new audio is created and shared to the device that intially gave the clip or other who has the decoding app,whoever is will act the role of slave.

The decoding app detects the watermark so it can be uploaded to the user the features of actual time song and the actual chord of the song (in this prototype is not the exact and is randomly generated).

# Division of the prototype System by Application

## Audio Fingerprinting identification
Application for PC called "Fingerprinting_1_0.mlapp" that takes from the microphone of the first device (that should be your PC) a random clip or a random segment of the song and returns the best fit song with its code of identification, in this case its index in the database.
## Spread spectrum Encoder
Also part of the master-first device.Called as "Encoder.mlapp".Takes the outuput of the Audio Fingerprinting process.Returns a wav file called "audio_watermarked.wav" and a .mat file "decoder.mat" that must be sent to the second-slave devices. 
## Spread spectrum decoder
Has a PC version called "Decoder.mlapp" and android mobile app version done in simulink called "decoderapp.slx" .Only for the considered second devicethat actually represents. Receive the watermarked song and decoding parameters to get the features of actual time and chord of the song.Returns also value of the success rate in the PC version.

# Installing & Running
Once you downloaded the ZIP or clone archive copy all its content in a folder fo your selection.

If you want to add your own songs to the database copy it to the folder songs inside src.

## Fingerprinting
Open the file called "Fingerprinting_1_0.mlapp" and run it.Push the "Create Database" button ,in case for be sure it was done right,open the file "make_database.m" and run it. 

After select the source of the clip.If it's from microphone prepare the corresponding speaker (example your cellphone playing the sound).Once it ends push the button to proceed to watermark for open Encoder app.
## Encoder
Run the "Encoder.mlapp" app.Fill the spaces given.

We recommend for bits of watermark 8,Frame Size 0.1  and Watermark factor 0.2 as these are constant values if not modified in the app mobile version at least.

Push the watermark audio button and wait for being done and that the plot appears. Once this happens push the create watermark button.This is ll create the two files that the decoder ll use to get the watermark. 

## Decoder
Send it via bluetooth the outputs of Encoder app, the wav file and decoder.mat, by the bluetooth windows interface for example (this means yo must connect the devices before) if your second device is a PC ,what's impotant is to make this audio and info will be in the same folder as the Decoder app ll be.

In the mobile app version from simulink  case, you need  in your simulink environment to specify in the "DataBaseSongs" block each of the path for the Audio File Read blocks inside it that correspond to each song in the folder "songs".

For now, for prototype limitations because of the restricted payload size bluetooth is giving,you had to also specify the path of the wav file in the block "Audio File Read Watermark".Specify also the value Key as the position in the database of the folder song of the matched song.

In future release f the mobile app  we'll implement TCP/IP or UDP protocol to send the info or  a code that send the data in encoder ,in decoder one that receives this data via bluetooth so it can be read from internal storage and the write in a variable of the activity.

In both cases run the app , PC version began the decoding process by pushing the Decode button and app iniates automatically.

# Future release improvements
For the sending the audio watermarked:

Implement a better communication protocol that can deal better with the payload size of the quantity of samples per block.

Also an activity that reads a prior the decoder parameters if we consider that the user should have access to them when encoding.

Design of the use of Generalized cross-correlation phase transform for improve synchronization in real time as has convenient properties to detect better the lags between first device signal and second device received.


# Author

Jonathan Leonard Crespo Eslava

License
GPL Version 3.

# Acknowledgments

SERVETTI ANTONIO-Professor of Automatic & Informatics department Politecnico di Torino






