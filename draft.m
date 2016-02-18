% Scrap from Project
%%
a = prnist(0:9,1:40:1e3);
% show(a,25)
%%
l = im_box(a,0,1);          % Centering in a black box
l = im_resize(l,[20 20]);   % Reshaping the number
l = im_box(l,1,0);          % Adding a black line to avoid edges with numbers parts
%%
close all
show(l,25)