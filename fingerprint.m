% function  rate_r= fingerprint(sound)
   function peaks = fingerprint(sound, fs)
% This function takes a sound and sampling frequency.  It returns a binary
% matrix indicating the locations of peaks in the spectrogram.
%
%inputs:
%sound:corresponding song or clip expressed in stereo format
%fs: samppling frequency of the song/clip. Tipically 44.1KHz
%


new_smpl_rate = 8000; % sampling rate
time_res = .064; % for spectrogram
gs = 3; % grid size for spectrogram peak search
desiredPPS = 30; % scales the threshold
% 
 y=sound;%for make data base
y=mean(y,2);%convert from stereo to mono
y=y-mean(y);% eliminate any bias
y=resample(y,new_smpl_rate,fs);
% Create the spectrogram
% Because the signal is real, only positive frequencies will be returned by
% the spectrogram function, which is all we will need.

window=64;
noverlap=32;
[S,F,T]=spectrogram(y,window,noverlap,[],new_smpl_rate);


magS=abs(S);


% Find the local peaks with respect to the nearest gs entries in both
% directions
peaks = ones(size(S)); % 2D boolean array indicating position of local peaks
for horShift = -gs:gs
    for vertShift = -gs:gs
        if(vertShift ~= 0 || horShift ~= 0) % Avoid comparing to self
            CS = circshift(magS, [horShift,vertShift]);
            P=(magS>CS);
            peaks=peaks&P;
        end
    end
end

 threshold = 1.05;
% % Calculate threshold to use.
% % We will set one threshold for the entire segment.  Improvements might be
% % possible by adapting the threshold throughout the length of the segment,
% % and setting a lower threshold for higher frequencies.
  peakMags = peaks.*magS;% magnitude of peaks 
  %ATTEMPT OF ADAPTATIVE THRESHOLD
%  res= min(factor(size(peakMags,2)));%resolution for adaptative threshold 
   res=23;
   cont=0;
   k=1;
   %We'll take part of the peaksMags matrix acocrding to the resolution
   %given
   %obtain all the peaks eliminating all the zeros and express it as a
   %peaks array
   %i calculate the geometric mean to this array and that ll be my threshold
   %We'll apply this threshold specific to the part of peakMags into
   %consideration
   %this result junk, of the matrix changed, by the one in the
   %respective position it was taken from.
   for t=1:size(peakMags,2)
       cont=cont+1;
       c=cont*res;
        
      %when i arrive to the last part of the matrix so we don't have
      %errors of index out of dimensions
            if(c>size(peakMags,2))
             c=size(peakMags,2);
             peaksth1=peakMags(:,k:c);
             sortedpeakMags = sort(peaksth1(:),'descend');
             sortedpeakMags=sortedpeakMags(sortedpeakMags ~= 0);
             threshold=geomean(sortedpeakMags);
             peaksth1 = (peaksth1 >= threshold);
             peaks(:,k:c)=peaksth1;
             break;
            else      
       peakth=peakMags(:,k:c);
      sortedpeakMags = sort(peakth(:),'descend');
       sortedpeakMags=sortedpeakMags(sortedpeakMags ~= 0);
        threshold=geomean(sortedpeakMags);
             peaksth = (peakth >= threshold);
             peaks(:,k:c)=peaksth;
            end  
     k=k+res; 
  end
%sortedpeakMags = sort(peakMags(:),'descend'); % sort all peak values in order
%threshold = sortedpeakMags(ceil(max(T)*desiredPPS));

%%%%%CODE FOR GET THE CURRENT PEAK RATE
% numb=0;
% cont=0;
% h=0;
% for k=1:size(peaks,2)
%     for t=1:size(peaks,1)
%         cont=cont+1;
%     if(peaks(t,k)==1)
%         numb=numb+1;
%     end
%     
%      if(mod(cont,8000)==0)
%        h=h+1;
%          rate(h)=numb;
%          numb=0;
%      end
%     end
% end
% rate_r=mean(rate);
 
%CODE TO DETERMINE THE PEAK RATE 

% peakMags_or=peaks;

% for threshold=1:0.1:5
%     peakMags = peaks.*magS;
% if (threshold > 0)
%     peaks = (peakMags >= threshold);
% end
% 
% numb=0;
% cont=0;
% h=0;
% for k=1:size(peaks,2)
%     for t=1:size(peaks,1)
%         cont=cont+1;
%     if(peaks(t,k)==1)
%         numb=numb+1;
%     end
%     
%      if(mod(cont,8000)==0)
%        h=h+1;
%          rate(h)=numb;
%          numb=0;
%      end
%     end
% end
% rate_r=mean(rate);
% if(rate_r==30)
%    break;
% else
%     peaks=peakMags_or;
%     h=0;
%     cont=0;
%     numb=0;
% end 
% end

% optional_plot = 0; % turn plot on or off
% 
% if optional_plot
%     % plot spectrogram
%     figure(1)
%     Tplot = [5, 10]; % Time axis for plot
%     logS = log(magS);
%     imagesc(T,F,logS);
%     title('Log Spectrogram');
%     xlabel('time (s)');
%     ylabel('frequency (Hz)');
%     axis xy
%     axis([Tplot, -inf, inf])
%     frame1 = getframe;
% 
%     % plot local peaks over spectrogram
%     peaksSpec = (logS - min(min(logS))).*(1-peaks);
%     imagesc(T,F,peaksSpec);
%     title('Log Spectrogram');
%     xlabel('time (s)');
%     ylabel('frequency (Hz)');
%     axis xy
%     axis([Tplot, -inf, inf])
%     frame2 = getframe;
% 
%     movie([frame1,frame2],10,1)
% end

end

