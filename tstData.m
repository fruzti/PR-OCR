% Test for large dataset
% Random training set is being used
index = randi(1e3,1,200);
trn = my_rep(prnist(0:9,index));
index = randi(1e3,1,100);
tst = my_rep(prnist(0:9,index));

%%
% Classifier Design
M = pcam(trn,38);
W = trn*M*vpc;

% Evaluating Classifier over Frozen Set
testc(tst*M*W)
for i=1:10
e(i)  = nist_eval('my_rep',M*W,100);
end
mean(e)
std(e)

%% Test for small dataset
% Random training set is being used
index = randi(1e3,1,10);
trn_best = my_rep(prnist(0:9,1:100));
trn_small = my_rep(prnist(0:9,index));
index = randi(1e3,1,100);
tst_small = my_rep(prnist(0:9,index));

%%
%%
% Classifier Design
M = pcam(trn_best,38);
W = trn_best*M*nmsc;

% Evaluating Classifier over Frozen Set
testc(tst_small*M*W)
%%
% Classifier Design
M = pcam(trn_small,38);
W = trn_small*M*nmsc;

% Evaluating Classifier over Frozen Set
testc(tst_small*M*W)
%%
for i=1:10
e(i)  = nist_eval('my_rep',M*W,100);
end
mean(e)
std(e)


