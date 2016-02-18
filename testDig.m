%% Gathering the Numbers
clear all
close all
I = imread('tst.jpg');
gray = rgb2gray(I);         %Gray Scale
% Threshold for Noise
mBW = mean(gray(:));        
sBW = std(double(gray(:)));
th = mBW - 2.5*sBW;
BW = gray < th;             % Binary Image
% Filtering the rest of Noise
I = medfilt2(BW,[5 5]);
I = imerode(I,strel('square',5));
I = imdilate(I,strel('square',20));
imshow(I)
%%
digits = [];
a=prdataset([]);
rpro = regionprops(I,'BoundingBox','Area');
j = 1;
for i=1:size(rpro)
    if rpro(i).Area > 1e3
        ob = imcrop(I,(rpro(i).BoundingBox));
        ob = imresize(ob,[20 20]);
        digits(:,:,j) = ob;
        rectangle('Position',rpro(i).BoundingBox,'EdgeColor','yellow')
        j = j+1;
    end
end
%%
dgt = im2obj(digits);
[o,f] = size(dgt);

labels_digits = [];

for i=1:o
    show(dgt(i,:))
    i_dgt = input('digit');
    labels_digits = [labels_digits i_dgt];
end

dgt = setlabels(dgt,labels_digits')

%%
pwer = my_rep_live(dgt);

