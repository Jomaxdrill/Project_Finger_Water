function pass=create_password(key)
%input:
%key ll be the number of the song
%output:
%pass associate password to use as parameter for gaussian generation
%
%
 pass = sum(double(key).*(1:length(key)));
 %a second version for encrypt the key using magic function
% pass = magic(key);
% pass=sum(mean(pass));
end