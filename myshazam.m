% Make a recording or 

recordingOn = 0; %1 for recording from microphone, 0 for random segment
duration = 10; % Seconds



global hashtable

% Check if we have a database in the workspace
if ~exist('songid')
    % Load database if one exists
    if exist('SONGID.mat')
        load('SONGID.mat');
        load('HASHTABLE.mat');
    else  
        msgbox('No song database');
        return;
    end
end

global numSongs
numSongs = length(songid);


if recordingOn
    % Settings used for recording.
    fs = 44100; % Sample frequency
    bits = 16;  % Bits used per sample

    % Record audio for <duration> seconds.
    recObj = audiorecorder(fs, bits, 2);
    handle1 = msgbox('Recording');
    recordblocking(recObj, duration);
    delete(handle1)

    % Store data in Double-precision array.
    sound = getaudiodata(recObj);
    
else % Select a random segment
    
    add_noise = 1; % Optionally add noise by making this 1.
    SNRdB = 5; % Signal-to-noise Ratio in dB, if noise is added.  Can be negative.
    
    dir = 'songs'; % This is the folder that the MP3 files are in.
    songs = getMp3List(dir);
    
    % Select random song
    thisSongIndex = ceil(length(songs)*rand);
    filename = strcat(dir, filesep, songs{thisSongIndex});
    [sound,fs] = audioread(filename);
    sound = mean(sound,2);
    sound = sound - mean(sound);
    
    % Select random segment
    if length(sound) > ceil(duration*fs)
        shiftRange = length(sound) - ceil(duration*fs)+1;
        shift = ceil(shiftRange*rand);
        sound = sound(shift:shift+ceil(duration*fs)-1);
    end
    
    % Add noise
    if add_noise
        soundPower = mean(sound.^2);
        noise = randn(size(sound))*sqrt(soundPower/10^(SNRdB/10));
        sound = sound + noise;
    end
end

 [bestMatchID, confidence,F]=match_segment(sound,fs);
 if(bestMatchID == 0)
     answer=0;
 else   
answer = songid{bestMatchID};   % Replace this line
 end
if recordingOn
   if(~answer)
       msgbox( {strcat('matched song:','no song found in the database') strcat('confidence:','It was nor possible to guess it') },'Recorded Segment' )
   else
    msgbox( {strcat('matched song:',answer) strcat('confidence:',int2str(confidence)) },'Recorded Segment' )
   end
else

if(~answer)
    msgbox( {strcat('Actual song:',songs{thisSongIndex}) strcat('match song:','clip was insufficient to determine it') strcat('confidence:','The segment was not informative')},'Random Segment' )
else
    msgbox( {strcat('Actual song:',songs{thisSongIndex}) strcat('match song:',answer) strcat('confidence:',int2str(confidence)) },'Random Segment' )
end
end