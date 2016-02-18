%% Test Dissimilarity
prwarning off
% Extracting test and training set from NIST
% Trn:Tst -> {1:10}
trn = my_rep(prnist(0:9,1:100:1e3));
tst = my_rep(prnist(0:9,1:10:1e3));

% Computing the Dissimilarity Matrix
% Dt = Sokal_Michener(trn,trn);   % For Training
% Ds = Sokal_Michener(tst,trn);   % For Testing
% Dt = RogersTanmoto(trn,trn);   % For Training
% Ds = RogersTanmoto(tst,trn);   % For Testing
Dt = trn*proxm(trn,'d',2);   % For Training
Ds = tst*proxm(trn,'d',2);   % For Testing
%--------------------------------------------------------------------------
% Note: The representation here is considered of the whole set of vectors
% in trn, this can be reduce by feature selection or randomly as in
% genddat() as in prdatatools.
%--------------------------------------------------------------------------

%% Desired Classifiers for Comparison
L = {'knnc','dtc','fisher','ldc','qdc','nbyc','nmc','nmsc','perlc','vpc','votec','parzen','svc'};

U = knnc;
U1 = dtc;
U2 = fisherc;
U3 = ldc;
U4 = qdc;
U5 = naivebc;
U6 = nmc;
U7 = nmsc;
U8 = perlc;
U9 = vpc;
U10 = [U,U2,U5]*votec;
U11 = parzenc;
U12 = svc;

V = {U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};
% M = pcam(Dt,34);
% Training Phase
% W = Dt*M*V;
W = Dt*V;

% Testing Phase
%--------------------------------------------------------------------------
% Note: Results using > 1e3 training set gives almost the same result as
% using the result from the functin nisteval given by the lecturers. (Using
% n = 100 the size of the data is set is the same, the only different is
% the permutation realized in the data).
%--------------------------------------------------------------------------
E = testc(Ds,W);    % The dissimilarity mapping is already done, a way to
                    % embbed it using prtools sintaxis is needed.
e = cell2mat(E);
plot(e,'.g')
set(gca,'XTick',[1:length(V)])
set(gca,'XTickLabel',L)
hold on, plot(0:0.01:length(V)+1,0.25,'r')

% Comfusion Matrix for the Best Classifier
[ep,i] = min(e);
disp('------------------------------------')
disp('Best Classifier:')
disp(upper(L{i}))
disp('Min. Error: ')
disp(ep)
confmat(Ds*W{i})

%% Feature Reduction
numFeat = [10:3:50];
for i=1:length(numFeat)
    Vaux = pcam([],numFeat(i))*V;   % Mapping for the n most signif. feat.
    W = Dt*Vaux;                    % Traning Classifier
    E = testc(Ds,W);                % Computing the error
    e_aux = cell2mat(E);
    Ep(:,i) = e_aux';
end
figure,
plot(Ep')
title('Feature Selection in Dissimilarity Space')
set(gca,'XTick',[1:length(numFeat)])
set(gca,'XTickLabel',numFeat)
xlabel('Features')
ylabel('Error')
legend(L)
xrc = [0 0 length(V)+1 length(V)+1];
yrc = [0 0.25 0.25 0];
hold on, fill(xrc,yrc,'b','FaceAlpha', 0.1)
hold on, plot(0:0.01:length(V)+1,0.25,'r')

%% 10-Folds CrossValidation for Generalization Purposes
M = pcam(Dt,34);
[CV,STD] = prcrossval(Dt,M*V,10,10);
errorbar(CV,STD)
title('10-Folds CrossValidation')
set(gca,'XTick',[1:length(V)])
set(gca,'XTickLabel',L)
xlabel('Classifiers')
ylabel('CV')
%% Mapping for Delivery
M = filtm([],'Sokal_Michener',{trn});
D = trn*M;
PCA = pcam(D,34);
W = D*PCA*ldc;
testc(tst*M*PCA*W)
%% 
M = filtm([],'RogersTanmoto',{trn});
D = trn*M;
PCA = pcam(D,10);
% W = D*PCA*ldc;
W = D*PCA*V;
% W = D*V;
testc(tst*M*PCA*W)
% testc(tst*M*W)