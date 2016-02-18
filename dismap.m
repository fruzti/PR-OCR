function D = dismap(a,d)
% function D = dismap(a,d)
% -------------------------------------------------------------------------
% Dissimilarity mapping using the prdataset a and the dissimilarity measure
% d. Returns a dissimilarity matrix D with size NxN where N is the number
% of objects in a.
%
% Options for parameter d:
% ---------------------------------
% 's' Sokal-Michener Dissimilarity
% 'j' Jaccard Dissimilarity 
% 'r' Rogers-Tanimoto Dissimilarity
% ---------------------------------

import DissimilarityMeasures

[o,~] = size(a);

D = zeros(o,o);
labs = zeros(o,1);
for i=1:o
    for j=1:o
        switch(d)
            case 's'
                D(i,j) = DissimilarityMeasures.dSokalmich(a(i,:),a(j,:));
            case 'j'
                D(i,j) = DissimilarityMeasures.dJaccard(a(i,:),a(j,:));
            case 'r'
                D(i,j) = DissimilarityMeasures.dRogersTanmoto(a(i,:),a(j,:));
        end
    end
    labs(i) = floor((i - 1)/10);
end
D = prdataset(D,labs); 
end