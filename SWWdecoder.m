%% get suspect watermarked audio and original
clear all
clc
[orig,fs]=audioread('Originalsong.mp3');%the original audio must be in the folder
%if you change it remember to change the input filename as well.
origw=audioread('audio_watermarked.wav');
N=0.1;
Lf=N*fs;
M=floor(length(orig)/Lf);%obtain the number of block M
alpha=0.2;
n=8;
%%get watermark of the frame
watermark=zeros(M,1);%initialize the array to store the watermak bits
idx=1;%it express a watermark every idx blocks 
%% Decoding
for k=0:idx:M %every 0.1 seconds add a watermark and add the end skip 
    
    init=(Lf*k)+1;
    fin=init+Lf-1;
    if(fin<=length(orig))
    origf=orig(init:fin);%get the block
    origwf=origw(init:fin);%get the block
    %get the current block for the watermark
    %calculate the DCT of the block
    dct_vector= dct(origf); 
    dct_vector_w=dct(origwf);
    %organize by power the spectrum so the highest components(more robust to noise) ill have the
    %watermarking
    [~, index] = max(abs(dct_vector));
    [~, indexw] = max(abs(dct_vector_w));
    % get the watermark
   wa = (dct_vector_w(indexw) - dct_vector(index))/alpha;
   %wa=sign(wa);
   watermark(k+1)=wa;
   else
        break;
   end
 end

%% get the watermark of the id song
key=5;%index number of the database song ,in this code you say which one,same as the one in the encoder
%positive integer number
passid=create_password(key);%i'll said for now is time 
idsong=GenerateGaussianSequence(passid,n);

%% compute success percentage ver 2
Successvalue=1;
Successsamples=0;
Pass=0;
bit=1;
for j=1:length(watermark)
        correctw=watermark(j);
        bit=mod(j,length(idsong));
        if(bit==0)
            bit=length(idsong);
        end
      Successvalue=Successvalue&(correctw==idsong(bit)); 
    if(Successvalue)
        Successsamples=Successsamples+1;
    end
    Successvalue=1;
end
Percentage=(Successsamples/M )*100;
%% compute success percentage 
Successvalue=1;
Successsamples=0;
Pass=0;
for j=1:length(watermark)
    for p=1:n
        correctw=watermark{j,1};
      Successvalue=Successvalue&(correctw(p)==idsong(p)); 
    end
    if(Successvalue)
        Successsamples=Successsamples+1;
    end
    Successvalue=1;
end
