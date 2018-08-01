function maxCollisions = add_to_table(tuple, songidnum)
%function maxCollisions = add_to_table(tuple, songidnum)
%
% Pass to this function a list of proximate pairs and the song ID number of
% the song that the pairs were taken from.
% 
% This function changes a global variable:  hashtable.  The tuples are
% appended to the hashtable.  The return value is not crucial, only for
% information.

global hashtable;

hashTableSize = size(hashtable,1);



% Count the max number of collisions for a given hash (FYI)
maxCollisions = 0;

        
for m = 1:size(tuple, 1);
    hash = simple_hash(tuple(m,3),tuple(m,4), tuple(m,2)-tuple(m,1), hashTableSize);
    %  first instance of this hash
    if isempty(hashtable{hash,1})
        hashtable{hash, 1} = songidnum; % # id of the song
        hashtable{hash, 2} = tuple(m,1); 
    % duplicate instance of this hash
    else
        hashtable{hash, 1} = [hashtable{hash, 1}, songidnum];
        hashtable{hash, 2} = [hashtable{hash, 2}, tuple(m,1)];

        collisions = length(hashtable{hash, 1});
        if collisions > maxCollisions
            maxCollisions = collisions;
        end
    end
end

end

