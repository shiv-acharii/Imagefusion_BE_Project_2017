
[row,column]=size(grey_matrixB);
counter = zeros(256,256);
%统计直方图
grey_matrixA=grey_matrixA+1;
grey_matrixB=grey_matrixB+1;
for i=1:row
    for j=1:column
        indexx = uint8(grey_matrixA(i,j));
        indexy = uint8(grey_matrixB(i,j));
        if(indexx~=0 && indexy~=0)
        counter(indexx,indexy) = counter(indexx,indexy)+1;%联合直方图
        end
        end
end
%计算联合信息熵
total= sum(counter(:));
index = find(counter~=0);
p = counter/total;
HabR = sum(sum(-p(index).*log2(p(index))));
        
        
