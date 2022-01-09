%基于m-PCNN的医学图像融合 MATLAB源程序
clc;
img1=imread('Kayak_Vis.jpg');
img2=imread('Kayak_IR.jpg');
figure(1);imshow(img1);
figure(2);imshow(img2);
img1=double(img1);
img2=double(img2);
[ROW,COL]=size(img1);
[ROW1,COL1]=size(img2);

if(ROW~=ROW1|COL~=COL1)
    error('input img1ges should be the same size!');
end 

% SET THE mPCNN PARAMEERS [W=M; BETA1=BETA2; DELTA; ALPHAT; VT]

BETA=0.5;     %%% note BETA1=BETA2; SO WE USE BETA FOR CONVENIENCE
M=[0.707,1,0.707;1,0,1;0.707,1,0.707];
DELTA=1;
ALPHAT=0.012;
VT=4000;          %%% MAKE SURE WHETHER THIS IS RIGHT.
%%%%%

img1WT=conv2(img1,M,'same');
img2WT=conv2(img2,M,'same');
SUMPIXEL=ROW*COL; %%% PIXELS NUMBER OF FUSED img1GE
JUDFIR=zeros(ROW,COL); %%% JUDFIR IS USED TO JUDGE WHETHER THE NEURON(I,J) IS FIRED
                  
THR=500*ones(ROW,COL);   
FI=zeros(ROW,COL);

%%% ITERATION
ITETIME=10;      %%% SET ITERATION TIME

for(itime=1:10)
for(i=1:ROW)
   for(j=1:COL)
       if(JUDFIR(i,j)~=1)   %%% THE NEURON SHOULD NOT BE FIRED YET.
      
       HA=img1WT(i,j)+img1(i,j);
       HB=img2WT(i,j)+img2(i,j);
       FI(i,j)=(1+BETA*HA)*(1+BETA*HB)+DELTA;
       
       if (FI(i,j)>THR(i,j))
           JUDFIR(i,j)=1;
       else             
           THR(i,j)=THR(i,j)*exp(-ALPHAT);
       end
       end   %%% end of JUDFIR

   end %%% end j
end     %%% end i
       if(sum(sum(JUDFIR))==SUMPIXEL)
           fprintf(1,'fused successfully');
           break 
       end     
end    %%% end itime
FI=FI/max(max(FI))*255;
figure;imshow(uint8(FI));
%imwrite(uint8(U),'U.gif');
%end %%% end of function

%prfomance matrices
cr1=corr2(img1,FI);
cr2=corr2(img2,FI);
fprintf('\nVisible img1ge and fused img1ge = %f\n',cr1);
fprintf('IR img1ge and fused img1ge = %f\n',cr2);

s1=snrr(double(img1),double(FI));
s2=snrr(double(img2),double(FI));

fprintf('snr of Visible and fused img1ge %4.2f\n',s1);
fprintf('snr of IR and fused img1ge %4.2f\n',s2)

%mutual information
grey_level=256;
img1=double(img1);
img2=double(img2);
MI=Evaluation(img1,img2,FI,grey_level);
fprintf('%4.2f\n',MI);