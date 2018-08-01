function hash = simple_hash(f1, f2, deltaT, size)
%function hash = simple_hash(f1, f2, deltaT, size)
%
%  Hash function: produces index to a hash table
%
% This is just intended to be a chaotic function with roughly a uniform
% distribution over the range.

hash = mod(round( size*1000000*(log(abs(f1)+2) + 2*log(abs(f2)+2) + 3*log(abs(deltaT)+2)) ), size) + 1;

end

