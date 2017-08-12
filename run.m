%function run(img)

img = imread('landmine.jpg');
imshow(img); 

%Crater recognization
pt=LoG_Blob(rgb2gray(img));
%draw(img,pt,'LOG');
opts = statset('Display','final');

%------------------cluster analysis for flight clouds----------------------
gpnum = 1;  % NOTE: Define number of clouds for flight
[cidx3,cmeans3,sumd3,D3] = kmeans(pt(:,1:2),gpnum,'dist','sqEuclidean');
%figure;  
imshow(img);  
hold on;  
axis on; 
MarkFace = {[0 0 1],[.8 0 0],[0 .5 0]};
X = pt(:,1:2);
for i =1:gpnum          %cluster analysis
    clust = find(cidx3 == i);
    bdx = zeros(size(clust));
    bdy = zeros(size(clust));
    for j=1:size(clust) 
    rectangle('Position',[pt(clust(j),2)-pt(clust(j),3),pt(clust(j),1)-pt(clust(j),3),2*pt(clust(j),3),2*pt(clust(j),3)],'Curvature',[1,1],'EdgeColor','y','LineWidth',2); 
    bdx(j) = pt(clust(j),2);
    bdy(j) = pt(clust(j),1);
    end
    
    %get the boundary of the cloud
    k = boundary(bdx,bdy);
    %expansion the cloud
    uy = zeros(size(clust));
    dy = zeros(size(clust));
    lx = zeros(size(clust));
    rx = zeros(size(clust));
    for j = 1:size(clust)
        uy(j) = bdy(j) + 10*pt(clust(j),3);
        dy(j) = bdy(j) - 10*pt(clust(j),3);
        lx(j) = bdx(j) - 10*pt(clust(j),3);
        rx(j) = bdx(j) + 10*pt(clust(j),3);
    end
    Cx = [bdx', bdx', bdx', lx', rx'];
    Cx = Cx';
    Cy = [bdy', uy', dy', bdy', bdy'];
    Cy = Cy';
    kk = boundary(Cx, Cy);
    CCx = zeros(size(kk));
    CCy = zeros(size(kk));   
   % NOTE: k is the boundary points of the cloud of spots. kk is the boundary
   % points of expaned cloud
   
   
    h = fill(bdx(k),bdy(k),'r');    %plot mine group boundary
    values = spcrv([Cx(kk)';Cy(kk)'],3);
    hh = fill(values(1,:),values(2,:),'r');    %paint expaned cloud
    set(h,'EdgeColor','none','facealpha',.3)
    set(hh,'EdgeColor','none','facealpha',.3)
    
end

%------------------------Oupput of txt files------------------------------
% Circles of recognization of craters NOTE: In the matrix pt the first
% column is the coordinate y the second column and the third column is the
% size
dlmwrite('Craters.txt', pt, 'precision', '%5f', 'delimiter', '\t')
% Cloud boundary of the craters
[size_k, a] = size(k);
bd = zeros(size_k, 2);
for i = 1: size_k
    bd(i,1) = bdx(k(i));
    bd(i,2) = bdy(k(i));
end
dlmwrite('Clouds.txt', bd, 'precision', '%5f', 'delimiter', '\t')
% Cloud boundary of the expaned cloud
[size_kk, b] = size(kk);
bdexp = zeros(size_kk, 2);
for i = 1: size_kk
    bdexp(i,1) = Cx(kk(i));
    bdexp(i,2) = Cy(kk(i));
end
dlmwrite('ExpandedCloud.txt', bdexp, 'precision', '%5f', 'delimiter', '\t')


%{
%Hough transform for straight lines recognization. The results depend on the quality of
%the picture.
  
Ihsv=rgb2gray(img);
Iedge = edge(Ihsv,'sobel');
%figure;
%imshow(Iedge);
hold on;
Iedge = imdilate(Iedge,ones(3));

[H1,T1,R1] = hough(Iedge,'Theta',1:0.1:89);
Peaks=houghpeaks(H1,5);
lines=houghlines(Iedge,T1,R1,Peaks);
for k=1:length(lines)
xy=[lines(k).point1;lines(k).point2];   
plot(xy(:,1),xy(:,2),'g','LineWidth',4);
end

[H2,T2,R2] = hough(Iedge,'Theta',-90:0.1:0);
Peaks1=houghpeaks(H2,5);
lines1=houghlines(Iedge,T2,R2,Peaks1);
for k=1:length(lines1)
xy1=[lines1(k).point1;lines1(k).point2];   
plot(xy1(:,1),xy1(:,2),'g','LineWidth',4);
end 
%}

hold off
%end
