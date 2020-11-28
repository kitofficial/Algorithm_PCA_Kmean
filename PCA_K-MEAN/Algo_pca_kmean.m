%Extracting the data
fid=fopen('seeds_dataset.txt','r');
Dataset=[];
for j=1:210
b=fgetl(fid);
c=strsplit(b);
Dataset(j,1:7)=[str2double(cell2mat(c(1))) str2double(cell2mat(c(2))) str2double(cell2mat(c(3))) str2double(cell2mat(c(4))) str2double(cell2mat(c(5))) str2double(cell2mat(c(6))) str2double(cell2mat(c(7)))];
end
fclose(fid);
% Dataset
A=Dataset;
% No of datas
L=length(A);
% mean of each attribute
a_mean = mean(A); 
% Mean shift the original matrix
D = bsxfun(@minus, A, a_mean);
% covariance matrix
covar_m = 1/(L-1) * (D' * D);
% eigenvectors(EV) eigenvalues(V)
[EV, V] = eig(covar_m);
% orthogonal
EV(:,1)' * EV(:,2)* EV(:,3)'* EV(:,4);
% eigenvalue
V = diag(V);
% sorting eigen value
[V, N] = sort(V, 1, 'descend');
% sorting eigen vectors
EV = EV(:,N);
% principal component matrix
PC_X = D * EV;
figure
% Plot PC1 vs PC2 vs PC3
scatter3(PC_X(:,1), PC_X(:,2),PC_X(:,3), 'o')
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component');
% 13.Reduced form
clus=(D * EV(:,[1,2]));



%K-mean program
centres = clus([2:4],:); % first randomly choosen cluster centres
K = size(centres, 1); % find number of clusters
[N dim] = size(clus); % dimensions of dataset
iteration_No = 100; % no. of iterations
Sq_Dis = zeros(K, N); % distances between cluster centres and datapoint stored in this KxN matrix 
fprintf('[0] Iteration: ')
centres % cluster centres at 0th iteration
for i = 1:iteration_No
 %finding squared distance between each cluster centre and each datapoint
for p = 1:K
Sq_Dis(p,:) = square_dist(clus, centres(p,:));
end
% Assignment of data in clusters
% "Act_dist" is the actual distances and "clus_assign" is the cluster assignments
[Act_dist, clus_assign] = min(Sq_Dis); % finding min distance for each datapoint
% Updating cluster centres
for q = 1:K
%checking the number of datapoints assigned to this cluster
if( sum(clus_assign==q) == 0 )
warn('k-means: cluster %d is empty', q)
else
centres(q, :) = mean(clus(clus_assign==q,:) );
end
end
% updated centres at nth iteration
fprintf('[%d] Iteration: ', i)
centres
end
%plot of the final clusters
figure;
plot(clus(clus_assign==1,1),clus(clus_assign==1,2),'r.','MarkerSize',12)
hold on
plot(clus(clus_assign==2,1),clus(clus_assign==2,2),'b.','MarkerSize',12)
hold on
plot(clus(clus_assign==3,1),clus(clus_assign==3,2),'g.','MarkerSize',12)
hold on
x_cent=[centres(1,1),centres(2,1),centres(3,1)];
y_cent=[centres(1,2),centres(2,2),centres(3,2)];
plot(x_cent,y_cent,'*','MarkerSize',25)




