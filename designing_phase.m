%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -KNN
% -Decision Tree
% -Fisher
% -Bayes
% -Logisitic 
% -Naive
% -NMC
% -NMSC
% -Perceptron
% -Polynomial
% -Voted Perceptron
% -Combined Classifier
% -Parzen Classifier
% -QDC

% Creating a trn using Pixel Representation
dataSet = prnist(0:9,1:1e3);

tst = dataSet(1:10:end,:);

trn = dataSet(1:100:end,:);

At = my_rep(trn);

As = my_rep(tst);
%% Pixel Representation
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

W = At*{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};

testc(As,W)

%%
v = {U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};
% F =At*featseli([],'NN',80);
Fi =At*featseli([],'in-in',80);
Ff =At*featself([],'in-in',80);
Fo =At*featselo([],'in-in',80);

Wi = At*Fi*v;
Wf = At*Ff*v;

testc(As*Fi,Wi);
testc(As*Ff,Wf);

%% W/ PCA 85%
U = pcam([],0.99)*knnc;
U1 = pcam([],0.99)*dtc;
U2 = pcam([],0.99)*fisherc;
U3 = pcam([],0.99)*ldc;
U4 = pcam([],0.99)*qdc;
U5 = pcam([],0.99)*naivebc;
U6 = pcam([],0.99)*nmc;
U7 = pcam([],0.99)*nmsc;
U8 = pcam([],0.99)*perlc;
U9 = pcam([],0.99)*vpc;
U10 = pcam([],0.99)*votec;
U11 = pcam([],0.99)*parzenc;
U12 = pcam([],0.99)*svc;

Wp = At*{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};

prcrossval(At,{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12},10,5)

testc(As,Wp)

%% W/ PCA 85%
U = pcam([],0.85)*knnc;
U1 = pcam([],0.85)*dtc;
U2 = pcam([],0.85)*fisherc;
U3 = pcam([],0.85)*ldc;
U4 = pcam([],0.85)*qdc;
U5 = pcam([],0.85)*naivebc;
U6 = pcam([],0.85)*nmc;
U7 = pcam([],0.85)*nmsc;
U8 = pcam([],0.85)*perlc;
U9 = pcam([],0.85)*vpc;
U10 = pcam([],0.85)*votec;
U11 = pcam([],0.85)*parzenc;
U12 = pcam([],0.85)*svc;

Wp = At*{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};

testc(As,Wp)

%% Using Dissimilarity
U = proxm([],'d',2)*knnc;
U1 = proxm([],'d',2)*dtc;
U2 = proxm([],'d',2)*fisherc;
U3 = proxm([],'d',2)*ldc;
U4 = proxm([],'d',2)*qdc;
U5 = proxm([],'d',2)*naivebc;
U6 = proxm([],'d',2)*nmc;
U7 = proxm([],'d',2)*nmsc;
U8 = proxm([],'d',2)*perlc;
U9 = proxm([],'d',2)*vpc;
U10 = [U,U2,U5]*votec;
U11 = proxm([],'d',2)*parzenc;
U12 = proxm([],'d',2)*svc;

Wd = At*{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};

testc(As,Wd)

%% %% Using Dissimilarity + PCA

U = proxm([],'d',2)*pcam([],0.99)*knnc;
U1 = proxm([],'d',2)*pcam([],0.99)*dtc;
U2 = proxm([],'d',2)*pcam([],0.99)*fisherc;
U3 = proxm([],'d',2)*pcam([],0.99)*ldc;
U4 = proxm([],'d',2)*pcam([],0.99)*qdc;
U5 = proxm([],'d',2)*pcam([],0.99)*naivebc;
U6 = proxm([],'d',2)*pcam([],0.99)*nmc;
U7 = proxm([],'d',2)*pcam([],0.99)*nmsc;
U8 = proxm([],'d',2)*pcam([],0.99)*perlc;
U9 = proxm([],'d',2)*pcam([],0.99)*vpc;
U10 = [U,U2,U5]*votec;
U11 = proxm([],'d',2)*pcam([],.99)*parzenc;
U12 = proxm([],'d',2)*pcam([],0.99)*svc;

Wd = At*{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};

testc(As,Wd)

%% %% Using Dissimilarity + PCA

U = proxm([],'m',2)*pcam([],0.99)*knnc;
U1 = proxm([],'m',2)*pcam([],0.99)*dtc;
U2 = proxm([],'m',2)*pcam([],0.99)*fisherc;
U3 = proxm([],'m',2)*pcam([],0.99)*ldc;
U4 = proxm([],'m',2)*pcam([],0.99)*qdc;
U5 = proxm([],'m',2)*pcam([],0.99)*naivebc;
U6 = proxm([],'m',2)*pcam([],0.99)*nmc;
U7 = proxm([],'m',2)*pcam([],0.99)*nmsc;
U8 = proxm([],'m',2)*pcam([],0.99)*perlc;
U9 = proxm([],'m',2)*pcam([],0.99)*vpc;
U10 = [U,U2,U5]*votec;
U11 = proxm([],'m',2)*pcam([],.99)*parzenc;
U12 = proxm([],'m',2)*pcam([],0.99)*svc;

Wd = At*{U,U1,U2,U3,U4,U5,U6,U7,U8,U9,U10,U11,U12};

testc(As,Wd)

%%
U1 = protselfd('random'); 
U1 = setname(U1,'random');
U2 = protselfd('LOO'); 
U2 = setname(U2,'LOO NN');
U3 = protselfd('maxdist'); 
U3 = setname(U3,'KCentres');
U4 = pcam;
U5 = featseli('NN'); 
U5 = setname(U5,'IndFeatSel');
U = {U1,U2,U3,U4,U5};
repeats = 5;

e = clevalf(D,nmsc,[1,2,3,5,7,10,15,20,30]);