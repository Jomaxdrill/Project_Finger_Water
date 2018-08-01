%% get song to watermark
clear all
[orig,fs]=audioread('Originalsong.mp3');%this is the audio you get for the fingerprinting identification
%copy it of the songs folder to the folder where this code and change its
%name to Original audio.
orig=mean(orig,2);
orig=orig-mean(orig);
%% params
n=8;%# bits watermark,id song,total watermark 24 bits
N=0.1;%length of the frame ill do it for now 0.01s
alpha=0.2;%attenuation factor
na=16;%number of bits to use for specify current block in the watermark 
%% get the watermark of the id song 
key=5;%index number of the database song ,in this code you say which one
passid=create_password(key);%i'll said for now is time 
idsong=GenerateGaussianSequence(passid,n);
%% embbed watermark per frame in the song
Lf=floor(N*fs);
M=floor(length(orig)/(Lf));%obtain the number of blocks M
origw=orig;%this copy is used to embed each watermark per block 
%and improve performance by already have allocation to store it.
idx=1;
%% Encoding
cont=1;
for k=0:idx:M %every 0.1 seconds add a watermark bit to the highest power
    
    init=(Lf*k)+1;
    fin=init+Lf-1;
    if(fin<=length(orig))
    origf=orig(init:fin);%get the block
    %%embbed watermark to it 
    %get the current block for the watermark
    %block=Tobits(k+1);
    % watermark=[block;idsong];

    watermark=idsong;
    bit=mod(cont,length(watermark));
    if(bit==0)
        bit=length(watermark);
        cont=1;
    end

    %calculate the DCT of the block
    dct_vector= dct(origf);    
    %watermarking
    [~,index]=max(abs(dct_vector));
  
    dct_vector(index) = dct_vector(index) + (watermark(bit) * alpha);

%    for_water{k}=dct_vector;
    water=idct(dct_vector);
% %    %add this to the new audio
     origw(init:fin)=water;
     cont=cont+1;
    else
        break;
    end
    ok=1;
end
%% plot
endin=length(origw)-1;
t=0:endin;
plot(t,origw,':r')
mani=max(origw);
mini=min(origw);

%% save the watermark file 
audiowrite('audio_watermarked.wav',origw,fs)

%% send watermark via bluetooth
% %create bluetooth object associated to the cellphone ,in this case my
% %cellphone
% b = Bluetooth('btspp://8058F8616678', 1);
% fopen(b);
% cont=0;
% for k=1:M
%     block=origw(cont+1:Lf*k);
%     fwrite(b,block,'float64');
%     cont=cont+Lf;
% end

%%%% send it via TCP /UDP future release




