%function[] = SWTimfuse1L_demo()
% Image fusion by (one level)discrete stationary wavelet transform  - demo
% by VPS Naidu, MSDF Lab, NAL, Bangalore
close all;
clear all;
home;

% insert images
im1 = double(imread('Road_IR.jpg'));
im2 = double(imread('Road_VIs.jpg'));
figure(1);
subplot(121);imshow(im1,[]);
subplot(122);imshow(im2,[]);

% image decomposition using discrete stationary wavelet transform
[A1L1,H1L1,V1L1,D1L1] = swt2(im1,1,'sym2');
[A2L1,H2L1,V2L1,D2L1] = swt2(im2,1,'sym2');

% fusion start
AfL1 = 0.5*(A1L1+A2L1);
D = (abs(H1L1)-abs(H2L1))>=0;
HfL1 = D.*H1L1 + (~D).*H2L1;
D = (abs(V1L1)-abs(V2L1))>=0;
VfL1 = D.*V1L1 + (~D).*V2L1;
D = (abs(D1L1)-abs(D2L1))>=0;
DfL1 = D.*D1L1 + (~D).*D2L1;

% fused image
imf = iswt2(AfL1,HfL1,VfL1,DfL1,'sym2');
figure(2); imshow(imf,[]);

CR1=corr2(im1,imf);
CR2=corr2(im2,imf);
fprintf('Co-relation between first image and fused image =%f \n\n',CR1);
fprintf('Co-relation between second image and fused image =%f \n\n',CR2);

S1=snrr(double(im1),double(imf));
S2=snrr(double(im2),double(imf));
fprintf('SNR between first image and fused image =%4.2f db\n\n',S1);
fprintf('SNR between second image and fused image =%4.2f db \n\n',S2);