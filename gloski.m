clear all;
tic
Fs=44100;
adsTrain=audioDatastore("probki_glosek",'IncludeSubfolders',true, ...
    'FileExtensions','.wav','LabelSource','foldernames');
reset(adsTrain);
for i=1:numel(adsTrain.Files)
    [x, dsInfo] = read(adsTrain);
    N=length(x);
    FFT_Y_R(:,i)=sqrt(fft(x).*conj(fft(x))/N);
    f=Fs*(0:(N/2-1))/N;    
    hr = harmonicRatio(x,Fs);
    hrPole(i) = trapz(hr);   
    freq(i) = meanfreq(x,Fs);
    varr(i)=var(x);
    stdd(i)=std(x);    
end
P_HR = normalize(hrPole,'range');
P_freq = normalize(freq,'range');
P_var = normalize(varr,'range');
P_std = normalize(stdd,'range');
w = 1;
v = 1;
for i=1:10:81    
    PARAMS(:,w:w+6) = [P_freq(1,i:i+6);P_HR(1,i:i+6);P_var(1,i:i+6);P_std(1,i:i+6)];
    TEST(:,v:v+2) = [P_freq(1,i+7:i+9);P_HR(1,i+7:i+9);P_var(1,i+7:i+9);P_std(1,i+7:i+9)];
    w = w+7;
    v = v+3;
end
toc
Pu = PARAMS;

T7 = [1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	0	0	0	0	0	0	0
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1
    ];
Pegz=TEST;
tic
B=[0 1];
PR=repmat(B,4,1);
mnet=newff(PR,[20 25 9],{'logsig' 'logsig' 'logsig'},'trainlm');
mnet=init(mnet);
mnet.trainParam.show=10000;
mnet.trainParam.epochs=3000;
mnet.trainParam.goal=10e-12;
mnet=train(mnet,Pu,T7);
YY=sim(mnet,Pegz).*100;
toc