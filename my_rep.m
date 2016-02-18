function rep = my_rep(a)

prwaitbar off

[o,~] = size(a);

classSize = o/10;
% labels = zeros(o,1);
labels = {{}};
data = [];

for d =0:9
    for e =1:classSize
        i = classSize*d+e;      % Elem. Number 
        el = a(i);              % Retriving element
        im = data2im(el);       % Converting datafile to image
        
        % Removing Slant
        im = im_box(im,[10,10,10,0]);
        M = im_moments(im,'central');       % Central Moments
        theta = atan(2*M(3)/(M(1)-M(2)));   % Skewness 
        S = [1 0 0; sin(0.5*pi-theta) cos(0.5*pi-theta) 0;0 0 1];
        T = maketform('affine',S);
        im = imtransform(im,T,'nearest');
        
        % Standarazing Size
        im = im_box(im,0,1);         % Centering in a black box
        im = im_resize(im,[20 20]);  % Reshaping the number
        im = im_box(im,1,0);         % Adding a black line to avoid edges with numbers parts
        
        data(i,:) = im(:);           % Dumping the image to data
        
        % Extracting Features if needed
        % data = feat_ext(data);
%         data(i,:) = HOG(im);
        
%         labels(i) = d;
        labels{i} = strcat('digit_',num2str(d));
    end
end

% If something is need to be applied:

% i.e Dissimilarity Generation

% rep = dismap(data,'s');

rep = prdataset(data,labels);