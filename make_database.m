% Read all MP3 files in 'dir' and add them to the database training if they
% are not already in 'songid'

dir = 'songs'; % This is the folder that the MP3 files must be placed in.
songs = getMp3List(dir);

hashTableSize = 100000; % This can be adjusted.  Setting it too small will cause more accidental collisions.

global hashtable

% Check if we have a database in the workspace
if ~exist('songid')
    % Load database if one exists
    if exist('SONGID.mat')
        load('SONGID.mat');
        load('HASHTABLE.mat');
    else  
        % Create new database
        songid = cell(0);
        hashtable = cell(hashTableSize,2); % 
    end
end


songIndex = length(songid); % This becomes the song ID number.

% Add songs to songid and fingerprints to hashtable
someNewSongs = 0;
for i = 1:length(songs)
    
    % Check if the song is already in the database
    songFound = 0;
    for m = 1:length(songid)
        if strcmp(songs{i}, songid{m})
            songFound = 1;
            break;
        end
    end
    
    if ~songFound
        someNewSongs = 1;
        songIndex = songIndex + 1;
        filename = strcat(dir, filesep, songs{i});
        [sound,fs] = audioread(filename);
        
        % INSERT CODE HERE
        % Use fingerprint.m, convert_to_pairs.m, and add_to_table.m
        peaks=fingerprint(sound,fs);
        tuple=convert_to_pairs(peaks);
        add_to_table(tuple,songIndex);
        songid{songIndex,1} = songs{i};
    end
end

global numSongs
numSongs = songIndex;
if someNewSongs
    save('SONGID.mat', 'songid');
    save('HASHTABLE.mat', 'hashtable');
end