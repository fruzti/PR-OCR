function rep = Sokal_Michener(x,d)
% function rep = Sokal_Michener(x,d)
% ----------------------------------
% Computes the dissimilarity between two prdatasets x and d.
% Where d is the dissimilarity representation set and Sokal_Michener is the
% metric applied to x.
% Returns a new prdataset with the original labels of x in the variable
% rep.

import DissimilarityMeasures

X = +x; % Extract Data from PRDATASETS
D = +d;

labx = getlab(x);
lab = {{}};

[xR,~] = size(X);
[dR,~] = size(D);

for i=1:xR
    for j=1:dR
        aux(i,j) = DissimilarityMeasures.dSokalmich(X(i,:),D(j,:));
    end
    lab{i} = strcat('digit_',num2str(labx(i)));
end

rep = prdataset(aux,lab);