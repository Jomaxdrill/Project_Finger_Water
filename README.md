# Project_Finger_Water
The following final project thesis is the set of applications for an audio recognition and second screen system via digital audio fingerprinting and watermarking techniques.The work is based on the papers of  Avery Li-chun Wang; "An Industrial-Strength Audio Search Algorithm" ,2003 and Ingemar J. Cox, Senior Member, IEEE, Joe Kilian, F. Thomson Leighton, and Talal Shamoon, Member, IEEE ;Secure Spread Spectrum Watermarking for Multimedia,1997.

Code implementation is based on the following sites: https://github.com/israkir/cox-watermarking and https://www.princeton.edu/~cuff/ele201/labs.html

# What is necessary
This project is fully develop in Matlab and should work both in windows/mac operating systems.However it's important that:

-The Matlab version is at least R2017a as it supports the use of simulink for program all android devices.

-Install the Simulink Support Package for Android Devices: Search in matlab on the Add Ons option for it.
# Explanation of the prototype system 

A database of songs is created for identify a piece of track that may match with one of the songs of this database.This is inside  a server-first device.

It's determined the song that fits best the fingerprint features of the clip and proceed to be encoded a watermark sequence via a secret key.

A new audio is created and shared to the device that intially gave the clip or other who has the decoding app,whoever is will act the role of slave.

The decoding app detects the watermark so it can be uploaded to the user the features of actual time song and the actual chord of the song (in this prototype is not the exact and is randomly generated).

# Divsion of the prototype System by Application

## Audio Fingerprinting identification
Application that takes from the microphone of the first device (that should be your PC) a random clip or a random segment of the song and returns the best fit song with its code of identification, in this case its index in the database.
## Spread spectrum Encoder
Also part of the master-first device.Takes the outuput of the Audio Fingerprinting process.Returns a wav file called "audio_watermarked.wav" and a .mat file "decoder.mat" that must be sent to the second-slave devices. 
## Spread spectrum decoder
Has a PC version called ""and android app version .Only for the considered second device. Receive the watermarked song and decoding parameters to get the features of actual time and chord of the song.Returns also value of the succes rate in the PC

# Installing
Once you downloaded the ZIP or clone archive copy all its content in a folder fo your selection.

If you want to add your own songs to the database copy it to the folder songs inside src.

For install in other pc as slave device do the following:

a) Copy the archive ""

# Running the Apps
## Fingerprinting

