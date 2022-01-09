%基于m-PCNN的医学图像融合 MATLAB源程序
IMA=imread('Road_IR.jpg');
IMB=imread('Road_Vis.jpg');
figure(1);imshow(IMA);
figure(2);imshow(IMB);
IMA=double(IMA);
IMB=double(IMB);
[ROW,COL]=size(IMA);
[ROW1,COL1]=size(IMB);
if(ROW~=ROW1|COL~=COL1)
    error('input images should be the same size!');
end 

%%%% SET THE mPCNN PARAMEERS [7 IN TOTAL]
%%%% W=M; BETA1=BETA2; DELTA; ALPHAT; VT;
BETA=0.5;     %%% note BETA1=BETA2; SO WE USE BETA FOR CONVENIENCE
M=[0.707,1,0.707;1,0,1;0.707,1,0.707];
DELTA=1;
ALPHAT=0.012;
VT=4000;          %%% MAKE SURE WHETHER THIS IS RIGHT.
%%%%%

IMAWT=conv2(IMA,M,'same'); %%% 卷积后保持源图像大小；
IMBWT=conv2(IMB,M,'same');
SUMPIXEL=ROW*COL; %%% PIXELS NUMBER OF FUSED IMAGE
JUDFIR=zeros(ROW,COL); %%% JUDFIR IS USED TO JUDGE WHETHER THE NEURON(I,J) IS FIRED
                  %%%JUDFIR用于判断神经元（i，j）是否激发。每个神经元在所有的迭代中只激发一次。
THR=500*ones(ROW,COL);     %%% 不知此阈值是否合适
U=zeros(ROW,COL);
%%% ITERATION
ITETIME=10;      %%% SET ITERATION TIME
for(itime=1:10)
for(i=1:ROW)
   for(j=1:COL)
       if(JUDFIR(i,j)~=1)   %%% THE NEURON SHOULD NOT BE FIRED YET.
       %%% 对单点进行迭代计算
       HA=IMAWT(i,j)+IMA(i,j);
       HB=IMBWT(i,j)+IMB(i,j);
       U(i,j)=(1+BETA*HA)*(1+BETA*HB)+DELTA;
       %%%判断是否激发
       if (U(i,j)>THR(i,j)) %% 满足条件则激发
           JUDFIR(i,j)=1;
       else             %% 不激发，对阈值进行衰减
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
U=U/max(max(U))*255;
figure;imshow(uint8(U));
%imwrite(uint8(U),'U.gif');
%end %%% end of function

CR1=corr2(IMA,U);
CR2=corr2(IMB,U);
fprintf('\nCo-relation between first image and fused image =%f \n\n',CR1);
fprintf('Co-relation between second image and fused image =%f \n\n',CR2);

S1=snrr(double(IMA),double(U));
S2=snrr(double(IMB),double(U));
fprintf('SNR between first image and fused image =%4.2f db\n\n',S1);
fprintf('SNR between second image and fused image =%4.2f db \n\n',S2);