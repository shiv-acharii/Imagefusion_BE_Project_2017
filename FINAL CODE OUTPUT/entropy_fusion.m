function entropyR=entropy_fusion(grey_matrix,grey_level)

[row,column,r]=size(grey_matrix);
total=row*column;
% grey_level=256 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter=zeros(1,grey_level);
grey_matrix=grey_matrix+1;
for i=1:row
    for j=1:column
        indexx= grey_matrix(i,j);
        if(uint8(indexx)~=0)
        counter(uint8(indexx))=counter(uint8(indexx))+1;
        end
    end
end
total= sum(counter(:));
index = find(counter~=0);
 p = counter/total;
entropyR= sum(sum(-p(index).*log2(p(index))));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%