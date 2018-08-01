function watermark_sequence = GenerateGaussianSequence(key,n)
% Generate normally distributed random numbers as a sequence
% Take their sign() to map them to {-1, 1}

% Parameters:
% (1) n: # of bits, if not specified n = 1000
% (2) key :actually the number of the song in data base,used as security

if (nargin == 0)
    n = 1000;
end
pass=create_password(key);
rng(pass);
watermark_sequence = sign(randn(n,1));
end

