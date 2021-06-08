clear;clc;
% file = xlsread(['C:\Users\cuixt\Desktop\73sampleLS\1015fc3.xlsx']);
file = xlsread(['C:\Users\cuixt\Desktop\normal2.xlsx']);
file1=file(1:end,1:end);
clus=3;
[idx,Ctrs,SumD,D] = kmeans(file1,clus);
file2=[idx,file1];
c1 = file2(file2(:,1)==1,2:end);
c2 = file2(file2(:,1)==2,2:end);
c3 = file2(file2(:,1)==3,2:end);
C{1}=c1;
C{2}=c2;
C{3}= c3;
[m1,q1] = size(c1);
[m2,q2] = size(c2);
[m3,q3] = size(c3);


Dist1=[];
for k1 = 1:m1-1
    x11=c1(k1,:);
    x12=c1(k1+1,:);
    dist1=norm(x11-x12);
    Dist1(:,end+1)=dist1;
end
maxdist1 = max(Dist1);%类1内的样本距离最大值
sumdist1 = sum(Dist1);
avedist1 =2./ m1./(m1-1).*sumdist1;

Dist2=[];
for k2 = 1:m2-1
    x21=c2(k2,:);
    x22=c2(k2+1,:);
    dist2 = norm(x21-x22); 
    Dist2(:,end+1)=dist2;
    
end
maxdist2 = max(Dist2);%类2内样本距离最大值
sumdist2 = sum(Dist2);
avedist2 =2./ m2./(m2-1).*sumdist2;
% 
% 
Dist3=[];
for k3 = 1:m3-1
    x31=c3(k3,:);
    x32=c3(k3+1,:);
    dist3 = norm(x31-x32);
    Dist3(:,end+1)=dist3;      
end
maxdist3 = max(Dist3);%类3内样本距离最大值
sumdist3 = sum(Dist3);
avedist3 =2./ m3./(m3-1).*sumdist3;


diamC=[maxdist1,maxdist2,maxdist3];%三类类内样本距离最大值合集
AVEdist{1} = avedist1;
AVEdist{2} = avedist2;
AVEdist{3} = avedist3;

DIST{1}=Dist1;
DIST{2}=Dist2;
DIST{3} = Dist3;

% DIST1=[Dist1;Dist2;Dist3];

%dmin
Mud3=[];
for j = 1:clus%最外层的循环，遍历j
    mud3=[];
    for i = 1:clus%第二层循环
        if i==j
           mutualdistance = 0;
        else
            ci = C{i};
            cj = C{j};
            [ri,vi] = size(ci);
            [rj,vj] = size(cj);
            Mud2=[];
            for R1=1:ri
                Mud1=[];
                for R2 = 1:rj
                    mutualdistance = norm(ci(R1,:)-cj(R2,:));
                    Mud1(:,end+1) = mutualdistance;
                end
                Mud2(end+1,:)=Mud1;%特定的第j类和第i类中任意两样本的距离矩阵
            end 
            mud2=min(min(Mud2));%特定的第j类和第i类中任意两样本最近距离
        end  
        mud3(:,end+1)=mud2;%固定j下，和任意i类样本最近距离的最小值
    end
    Mud3(end+1,:)=mud3;%任意j类和任意i类的样本最近距离的最小值的集合
    minmutualf = min(min(Mud3));%任意j类和任意i类中，计算任意两个样本见得距离，其最小值
end
di=minmutualf/max(max(DIST));
