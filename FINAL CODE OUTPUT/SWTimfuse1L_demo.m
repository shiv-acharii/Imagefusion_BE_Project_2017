%function[] = SWTFIuse1L_demo()


close all;

clear all;
home;

% insert images
img1 = double(imread('Steamboat_Vis.jpg'));
img2 = double(imread('Steamboat_IR.jpg'));
figure(1);
subplot(121);imshow(img1,[]);
subplot(122);imshow(img2,[]);

img1=imresize(img1,[510 506]);
img2=imresize(img2,[510 506]);

% image decomposition using discrete stationary wavelet transform
[A1L1,H1L1,V1L1,D1L1] = swt2(img1,1,'sym2');
[A2L1,H2L1,V2L1,D2L1] = swt2(img2,1,'sym2');

% fusion start
AfL1 = 0.5*(A1L1+A2L1);
D = (abs(H1L1)-abs(H2L1))>=0;
HfL1 = D.*H1L1 + (~D).*H2L1;
D = (abs(V1L1)-abs(V2L1))>=0;
VfL1 = D.*V1L1 + (~D).*V2L1;
D = (abs(D1L1)-abs(D2L1))>=0;
DfL1 = D.*D1L1 + (~D).*D2L1;

% fused image
FI = iswt2(AfL1,HfL1,VfL1,DfL1,'sym2');
figure(2); imshow(FI,[]);

%prfomance matrices
CR1=corr2(img1,FI);
CR2=corr2(img2,FI);
S1=snrr(double(img1),double(FI));
S2=snrr(double(img1),double(FI));


fprintf('Correlation between Visible image and fused image =%f \n\n',CR1);
fprintf('Correlation between IR image and fused image =%f \n\n',CR2);
fprintf('SNR between Visible image and fused image =%4.2f db\n\n',S1);
fprintf('SNR between IR image and fused image =%4.2f db \n\n',S2);

%mutual information
grey_level=256;
img1=double(img1);
img2=double(img2);
MI=Evaluation(img1,img2,FI,grey_level);
fprintf('%4.2f\n',MI);