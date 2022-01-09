clc;

nLevel = 4; %number of decompositions
lambda=30;

img1=imread('meting1_Vis.bmp');%read Vis image
img2=imread('meting1_IR.bmp');%read IR image 

%display input images
figure(1),title('Visible image'),imshow(img1);
figure(2),title('Infrared Image'),imshow(img2);

img1=double(img1);
img2=double(img2);


%% ---------- Hybrid Multi-scale Decomposition --------------
sigma = 2.0; %std deviation of spartial gaussian
sigma_r = 0.05; %std deviation of range gaussian
k = 2;

%Gaussian and bilateral filter applied to Visible image

M1 = cell(1, nLevel+1);
M1L = cell(1, nLevel+1);
M1{1} = img1;
M1L{1} = img1;
M1D = cell(1, nLevel+1);%decomposed textured detail stored
M1E = cell(1, nLevel+1);%decomposed edge detail stored
sigma0 = sigma;
for j = 2:nLevel+1,
    w = floor(3*sigma0);

   %apply gaussian filter
    h = fspecial('gaussian', [2*w+1, 2*w+1], sigma0);   
    M1{j} = imfilter(M1{j-1}, h, 'symmetric');
    
    %apply bilateral filter
    M1L{j} = 255*bfilter2(M1L{j-1}/255,w,[sigma0, sigma_r/(k^(j-2))]);
    
 %get the textured detail from substraction of prev gaussian with bilateral filter 
    M1D{j} = M1{j-1} - M1L{j};

%get the edge features
    M1E{j} = M1L{j} - M1{j};
    
    sigma0 = k*sigma0;
end

%Gaussian and bilateral filter applied to Visible image

M2 = cell(1, nLevel+1);
M2L = cell(1, nLevel+1);
M2{1} = img2;
M2L{1} = img2;
M2D = cell(1, nLevel+1);%decomposed textured detail stored
M2E = cell(1, nLevel+1);%decomposed edge detail stored
sigma0 = sigma;
for j = 2:nLevel+1,
    w = floor(3*sigma0);
    h = fspecial('gaussian', [2*w+1, 2*w+1], sigma0);   
    M2{j} = imfilter(M2{j-1}, h, 'symmetric');
    M2L{j} = 255*bfilter2(M2L{j-1}/255,w,[sigma0, sigma_r/(k^(j-2))]);
    
 %get the textured detail from substraction of prev gaussian with bilateral filter 
    M2D{j} = M2{j-1} - M2L{j};
%get the edge features
    M2E{j} = M2L{j} - M2{j};

    sigma0 = k*sigma0;
end

%%Multi-scale Combination 

for j = nLevel+1 : -1 : 3
b2 = abs(M2E{j});
b1 = abs(M1E{j});
R_j = max(b2-b1, 0);
Emax = max(R_j(:));
P_j = R_j/Emax;

C_j = atan(lambda*P_j)/atan(lambda);

% Base level combination

sigma0 = 2*sigma0;
if j == nLevel+1
    w = floor(3*sigma0);
    h = fspecial('gaussian', [2*w+1, 2*w+1], sigma0);
    lambda_Base = lambda;
    %lambda_Base = 30;
    C_N = atan(lambda_Base*P_j)/atan(lambda_Base);
    C_N = imfilter(C_N, h, 'symmetric');
    MF = C_N.*M2{j} + (1-C_N).*M1{j};
end

% Large-scale combination

sigma0 = 1.0;
w = floor(3*sigma0);
h = fspecial('gaussian', [2*w+1, 2*w+1], sigma0);   
C_j = imfilter(C_j, h, 'symmetric');

D_F = C_j.*M2E{j}+ (1-C_j).*M1E{j};
MF = MF + D_F;
D_F = C_j.*M2D{j}+ (1-C_j).*M1D{j};
MF = MF + D_F;
end 

% Small-scale combination

sigma0 = 0.5;
w = floor(3*sigma0);
h = fspecial('gaussian', [2*w+1, 2*w+1], sigma0);   
C_0 = double(abs(M1E{2}) < abs(M2E{2}));
C_0 = imfilter(C_0, h, 'symmetric');
D_F = C_0.*M2E{2}+ (1-C_0).*M1E{2};
MF = MF + D_F;  
C_0 = abs(M1D{2}) < abs(M2D{2});
% C_0 = imfilter(C_0, h, 'symmetric');
D_F = C_0.*M2D{2}+ (1-C_0).*M1D{2};
MF = MF + D_F;

% Fusion Result 
FI = ImRegular(MF);   % The intensities are regulated into [0, 255]
FI = max(min(FI,255), 0);
%paraShow.fig = 'Fusion result';
%ShowImageGrad(MF, paraShow);
FI=uint8(FI);
figure(3),title('Fused image'),imshow(FI);

%prfomance matrices
cr1=corr2(img1,FI);
cr2=corr2(img2,FI);
fprintf('\nVisible image and fused image = %f\n',cr1);
fprintf('IR image and fused image = %f\n',cr2);

s1=snrr(double(img1),double(FI));
s2=snrr(double(img2),double(FI));

fprintf('snr of Visible and fused image %4.2f\n',s1);
fprintf('snr of IR and fused image %4.2f\n',s2)

%mutual information
grey_level=256;
MI=Evaluation(img1,img2,FI,grey_level);
fprintf('%4.2f\n',MI);
