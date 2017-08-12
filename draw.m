function draw(img,pt,str)
%���ܣ���ͼ���л���������  
%img??����ͼ��  
%pt??����������  
%str??ͼ����ʾ������  
figure('Name',str);  
imshow(img);  
hold on;  
axis on;  
switch size(pt,2)  
    case 2  
        s=2;  
        for i=1:size(pt,1)  
            rectangle('Position',[pt(i,2)-s,pt(i,1)-s,2*s,2*s],'Curvature'...  
                ,[0,0],'EdgeColor','b','LineWidth',2);  
        end  
    case 3  
        for i=1:size(pt,1)  
            rectangle('Position',[pt(i,2)-pt(i,3),pt(i,1)-pt(i,3),...  
                2*pt(i,3),2*pt(i,3)],'Curvature',[1,1],'EdgeColor',...  
                'y','LineWidth',2);  
            %X(idx==1,1) X(id==1,2)
        end  
end  

hold off;
end 
