function tuple = convert_to_pairs(peaks)
%
% This code takes a binary matrix as input and returns a list of proximate
% peaks.  There are three parameters in the code to change the range of the
% search and the number of pairs allowed per peak.
%
% There is also an optional plot which shows the peaks and lines connecting
% the pairs.  Zoom in to the plot to see the peaks better.


del_t = 35; % bound on time difference (in pixels)
del_f = 30; % bound on frequency difference (in pixels)
fanout = 3; % Maximum number of pairs per peak.


[f, t] = find(peaks);
peakCount = length(f);

tuple = zeros(fanout*peakCount, 4);
index = 1;


% This code looks more complicated than it is.  Mostly it's tedious things,
% like making sure that We don't index outside of the matrix.
for i = 1:peakCount
    links = 0;
    for f2 = min(size(peaks,1),f(i)+1):min(size(peaks,1),f(i)+del_f)
        if peaks(f2,t(i))
            tuple(index, :) = [t(i) t(i) f(i) f2];
            links = links + 1;
            index = index + 1;
        end
        if (links >= fanout)
            break;
        end
    end
    for t2 = min(size(peaks,2),t(i)+1):min(size(peaks,2),t(i)+del_t)
        if (links >= fanout)
            break;
        end
        for f2 = max(1,f(i)-del_f):min(size(peaks,1),f(i)+del_f)
            if (links >= fanout)
                break;
            end
            if peaks(f2,t2)
                tuple(index, :) = [t(i) t2 f(i) f2];
                links = links + 1;
                index = index + 1;
            end
        end
    end
end

tuple = tuple(1:(index - 1), :);


optional_plot = 0; % turn plot on or off

if optional_plot
    figure(2)
    clf
    imagesc(peaks)
    axis xy;
    colormap(1-gray)
    hold on
    for i = 1:size(tuple,1)
        line([tuple(i,1), tuple(i,2)], [tuple(i,3), tuple(i,4)])
    end
    hold off
    title('Pairs')
    xlabel('Time')
    ylabel('Frequency')
end

