%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class DissimilarityMeasures                                             %
%                                                                         %
% Description:                                                            %
% Set of dissimilarity measures for binary vectors.                       %
%                                                                         %
% Date:                                                                   % 
% 20.11.14                                                                %
%                                                                         %
% Authors:                                                                %                    
% Mario Coutino                                                           %
% Kris Shrishak                                                           %
%                                                                         %
% TU Delft                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef DissimilarityMeasures
    
    methods (Static)
        
        function [nft,ntf] = nbool_correspond_ft_tf(u,v)
            not_u = ~u;
            not_v = ~v;
            nft = sum(not_u & v);
            ntf = sum(u & not_v);
        end
        
        function [nff, nft, ntf, ntt] = nbool_correspond_all(u,v)
            not_u = ~u;
            not_v = ~v;
            nff = sum(not_u & not_v);
            nft = sum(not_u & v);
            ntf = sum(u & not_v);
            ntt = sum(u & v);
        end
        
        function d = dSokalmich(u,v)
            % Sokal-Michener dissimilarity
            [nft,ntf] = DissimilarityMeasures.nbool_correspond_ft_tf(u,v);
            ntt = sum(u & v);
            nff = sum(~u & ~v);
            d = 2.0*(ntf + nft)/(ntt+nff+2.0*(ntf+nft));
        end

        function d = dJaccard(u,v)
            % Jaccard distance
            d = sum((u ~= v) & ((u~=0)|(v~=0)))/sum((u~=0)|(v~=0));
        end
        
        function d = dRogersTanmoto(u,v)
            % Rogers-Tanimoto dissimilarity
            [nff, nft, ntf, ntt] = DissimilarityMeasures.nbool_correspond_all(u,v);
            d = 2.0*(ntf+nft)/(ntt+nff+(2.0*(ntf+nft)));
        end
       
    end
end