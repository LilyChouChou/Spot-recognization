function [points]=LoG_Blob(img,num_blobs)  %function: Extract Log spots 
img=double(img(:,:,1));  
if nargin==1    %If input is only 1£¨img£©  
    num=120;    %Set the number of spots 120  
else  
    num=num_blobs;  
end  
%Set log parameters
sigma_begin=2;  
sigma_end=15;  
sigma_step=1;  
sigma_array=sigma_begin:sigma_step:sigma_end;  
sigma_nb=numel(sigma_array);  
    %n = numel(A) returns the number of elements, n, in array A  
    %equivalent to prod(size(A)).  
img_height=size(img,1);  
img_width=size(img,2);  

snlo=zeros(img_height,img_width,sigma_nb);  
for i=1:sigma_nb  
    sigma=sigma_array(i);  
    snlo(:,:,i)=sigma*sigma*imfilter(img,fspecial('log',...  
        floor(6*sigma+1),sigma),'replicate');  
end  
%Searching for peaks
snlo_dil=imdilate(snlo,ones(3,3,3));  
blob_candidate_index=find(snlo==snlo_dil);  
blob_candidate_value=snlo(blob_candidate_index);  
[temp,index]=sort(blob_candidate_value,'descend');  
blob_index=blob_candidate_index(index(1:min(num,numel(index))));  
[lig,col,sca]=ind2sub([img_height,img_width,sigma_nb],blob_index);  
points=[lig,col,3*reshape(sigma_array(sca),[size(lig,1),1])];  
end
