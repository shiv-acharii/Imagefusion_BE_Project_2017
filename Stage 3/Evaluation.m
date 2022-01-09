

Result=zeros(1,2);
Result(1,1)=mutural_information(grey_matrixA,grey_matrixB,fusion_matrix,grey_level);
Result(1,2)=edge_association(grey_matrixA,grey_matrixB,fusion_matrix);
disp('|| MI || QAB/F ||')

