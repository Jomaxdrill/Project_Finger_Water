 %function [bestMatchID, confidence] = match_segment(clipp)
function [bestMatchID, confidence,F] = match_segment(clip, fs)

%  This function requires the global variables 'hashtable' and 'numSongs'
%  in order to work properly.Gets the fingerprint of a given clip and
%  returns the best fit song similarity in the database song.Also express
%  it as a Confidence level.
%
%inputs:
%sound:corresponding song or clip expressed in stereo format
%fs: samppling frequency of the song/clip. Tipically 44.1KHz
%
%outputs:
%bestMatchID: The song that the algorithm considers is the song
%confidence: a quantity to express how sure the programm is sure about the
%result.
%F: Frequencies of the clip with respect to each song
 


global hashtable
global numSongs

hashTableSize = size(hashtable,1);


% Find peak pairs from the clip
% %temporal code 
% [clip,fs]=audioread('sev.mp3');
peaks_clip=fingerprint(clip,fs);
clipTuples=convert_to_pairs(peaks_clip);
% clipTuples = 0;     % Replace this linesomeNewSongs

% Construct the cell of matches
matches = cell(numSongs,1);
for k = 1:size(clipTuples, 1)
%     clipHash = 1;   % Replace this line
    clipHash=simple_hash(clipTuples(k,3),clipTuples(k,4), clipTuples(k,2)-clipTuples(k,1), hashTableSize);
    % If an entry exists with this hash, find the song(s) with matching peak pairs
     if (~isempty(hashtable{clipHash, 1}))
         matchID = hashtable{clipHash, 1}; % row vector of collisions
         matchTime = hashtable{clipHash, 2}; % row vector of collisions
%         
%         % Calculate the time difference between clip pair and song pair
%         % INSERT CODE HERE
         Time_offset= matchTime-clipTuples(k,1);
%                 
%         % Add matches to the lists for each individual song
        for n = 1:numSongs
              matches{n} = [matches{n},Time_offset(find(matchID==n))];
         end
    end
end

% % Find the counts of the mode of the time offset array for each song
 M=zeros(numSongs,1);
 F=zeros(numSongs,1);
 for k = 1:numSongs
     [M(k),F(k)]=mode(matches{k});
%  
 end
 %Determine the song
 %One idea might be a threshold of mode , if is it's enough certain number
 %so to express confidence.
%Other ll be calculate the variance between the frequencies if it's too
%high means one song has more ocurrencies than the others
 if((var(F)>100))%value to tune
 Fmax=max(F);
    bestMatchID=find(F==Fmax);

 confidence=1;
 else
     bestMatchID=0;
     confidence=0;
     
 end

optional_plot = 1; % turn plot on or off

if optional_plot
    figure(3)
    clf
    y = zeros(length(matches),1);
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        histogram(matches{k},1000)
        y(k) = max(hist(matches{k},1000));
    end
    
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        axis([-inf, inf, 0, max(y)])
    end

    subplot(length(matches),1,1)
    title('Histogram of offsets for each song')
end

 end

