# Project_Finger_Water
The following final project thesis is the set of applications for an audio recognition and second screen system via digital audio fingerprinting and watermarking techniques.The work is based on the papers of  Avery Li-chun Wang; "An Industrial-Strength Audio Search Algorithm" ,2003 and Ingemar J. Cox, Senior Member, IEEE, Joe Kilian, F. Thomson Leighton, and Talal Shamoon, Member, IEEE ;Secure Spread Spectrum Watermarking for Multimedia,1997.

Code implementation is based on the following sites: https://github.com/israkir/cox-watermarking and https://www.princeton.edu/~cuff/ele201/labs.html

# What is necessary
This project is fully develop in Matlab and should work both in windows/mac operating systems.However it's important that:

-The Matlab version is at least R2017a as it supports the use of simulink for program all android devices.

-Install the Simulink Support Package for Android Devices: Search in matlab on the Add Ons option for it.
# Explanation of the system 

A database of songs is created for identify a piece of track that may match with one of the songs of this database.This is inside  a server-first device.
It's determined the song that fits best the fingerprint features of the clip and proceed to be encoded a watermark sequence via a secret key.
A new audio is created and shared to the device that intially gave the clip or other who has the decoding app,whoever is will act the role of slave.
The decoding app detects the watermark so it can be uploaded to the user the features of actual time song and the actual chord of the song (in this prototype is not the exact and is randomly generated).

# Installing
# Running the Apps
## Fingerprinting

