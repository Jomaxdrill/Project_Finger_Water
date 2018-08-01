function bits=Tobits(number)
%This function takes a message that is in decimal format between  0-65535
%returns its serial sequence of integer 16 bits {-1,1}  where -1 is refer to
%as 0 state value.
% 
sequence=dec2bin(number);
bits=zeros(length(sequence),1);%create a columm
for i=1:length(sequence)
 bits(i)=(sequence(i)==49);  
 if bits(i) == 0
       bits(i) = -1;
 end
end
h=length(bits);
bits=[ones(16-h,1)*-1;bits];
end