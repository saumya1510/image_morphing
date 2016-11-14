clc;
clear all;
imgPath1 = 'C:\Users\Saumya\Pictures\face1.jpg';
imgPath2 = 'C:\Users\Saumya\Pictures\face2.jpg';
img1 = imread(imgPath1);
img1 = imresize(img1,[480,650]);
img2 = imread(imgPath2);
img2 = imresize(img2,[480,650]);
f1 = figure;
f1,imshow(img1);
[X1,Y1] = ginput();
hold on
tri1 = delaunay(X1,Y1);
trimesh(tri1,X1,Y1);
X1 = [X1;1;1;650;650];
Y1 = [Y1;1;480;480;1];


f2 = figure;
f2,imshow(img2);
[X2,Y2] = ginput();
tri2 = delaunay(X2,Y2);
trimesh(tri2,X2,Y2);
close(f1);
close(f2);
X2 = [X2;1;1;650;650];
Y2 = [Y2;1;480;480;1];

X3 = (X1+X2)/2;
Y3 = (Y1+Y2)/2;

tform1 = fitgeotrans([X1 Y1],[X3 Y3],'pwl');
tform2 = fitgeotrans([X2 Y2],[X3 Y3],'pwl');
ra = imref2d(size(img1));

img3 = imwarp(img1,tform1,'OutputView', ra);
img4 = imwarp(img2,tform2,'OutputView', ra);

img5 = 0.5*img3+0.5*img4;
figure,imshow(img3);figure,imshow(img4);figure,imshow(img5);
