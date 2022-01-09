
clc;
clear all;
close all;
%%
A=imread('Camp_IR.jpg');
B=imread('Camp_Vis.jpg');
F=imread('Camp_fus_MSD.jpg');
%%
A=double(A);
B=double(B);
F=double(F);
%%
grey_level=256;
Criteria=Evaluation(A,B,F,grey_level)