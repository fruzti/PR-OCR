function rep = RogersTanmoto(x,d)
% function rep = RogersTanmoto(x,d)
% ----------------------------------
% Computes the dissimilarity between two prdatasets x and d.
% Where d is the dissimilarity representation set and RogersTanmoto is the
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
        aux(i,j) = DissimilarityMeasures.dRogersTanmoto(X(i,:),D(j,:));
    end
    lab{i} = strcat('digit_',num2str(labx(i)));
end

rep = prdataset(aux,lab);