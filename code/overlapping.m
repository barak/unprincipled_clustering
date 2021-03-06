%% set simulation parameters
clc; clear all;
n=100;     % number of samples
r=2;        % rank of *each* subspace
k=3;        % number of subspaces
c=3;        % mean shift of subspaces
kr=k*r;     % sum of ranks
d=10;   % ambient dimension
if d<kr, display('dim is too small'), break, end;

%% generate data
U={};
UU=orth(randn(d,r+k-1)); % Only works for r=2
for i=1:k
    U{i}=UU(:,i:i+r-1);
end

data=[];
for i=1:k
    Y{i}=U{i}*(c*randn(r,1)*ones(1,n)+randn(r,n));
    data=[data Y{i}];
end
 

% project data on true low-dimensional subspaces
proj = (UU\data)';

% rewrite over UU to have all the bases
UU=[];
for i=1:k
    UU=[UU U{i}];
end

kk=1;
colors{1}='k';
colors{2}='r';
colors{3}='b';
colors{4}='g';
figure(1); clf
for i=1:kr
    for j=i:kr
        subplot(kr,kr,sub2ind([kr kr], j, i));
        for ll=1:k, hold on
            plot(proj(n*(ll-1)+1:ll*n,i),proj(n*(ll-1)+1:ll*n,j),...
                '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll});
        end
        %         ylabel(['subspace dim ', num2str(i)])
        %         xlabel(['subspace dim ', num2str(j)])
        %         set(gca,'XTick',[],'Ytick',[]);
        if kk==1, title('true projection'), end
        kk=kk+1;
    end
end
print('-dpng',['true2d_r', num2str(r),'_k', num2str(k),'_d',num2str(d),'_n',num2str(n)])

%% plot truth in 3d
figure(2), clf
for ll=1:k,
    subplot(221), hold on
    plot3(proj(n*(ll-1)+1:ll*n,1),proj(n*(ll-1)+1:ll*n,2),proj(n*(ll-1)+1:ll*n,3),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('1'), ylabel('2'), zlabel('3')
    subplot(222), hold on
    plot3(proj(n*(ll-1)+1:ll*n,1),proj(n*(ll-1)+1:ll*n,2),proj(n*(ll-1)+1:ll*n,4),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('1'), ylabel('2'), zlabel('4')
    subplot(223), hold on
    plot3(proj(n*(ll-1)+1:ll*n,1),proj(n*(ll-1)+1:ll*n,3),proj(n*(ll-1)+1:ll*n,4),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('1'), ylabel('3'), zlabel('4')
    subplot(224), hold on
    plot3(proj(n*(ll-1)+1:ll*n,2),proj(n*(ll-1)+1:ll*n,3),proj(n*(ll-1)+1:ll*n,4),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('2'), ylabel('3'), zlabel('4')
end
print('-dpng',['true3d_r', num2str(r),'_k', num2str(k),'_d',num2str(d),'_n',num2str(n)])


%% find optimal linear embedding and plot
options.disp=1;
[uu ss vv] = svds(data,kr,10^9,options);
v=vv(:,1:kr);
figure(3); clf
kk=1;
for i=1:kr
    for j=i:kr
        subplot(kr,kr,sub2ind([kr kr], j, i));
        for ll=1:k, hold on
            plot(v(n*(ll-1)+1:ll*n,i),v(n*(ll-1)+1:ll*n,j),...
                '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll});
        end
        %         plot(v(:,i),v(:,j),'r.');
        %         ylabel(['eig ', num2str(i)])
        %         xlabel(['eig ', num2str(j)])
        %         set(gca,'XTick',[],'Ytick',[]);
        if kk==1, title('eigen-decomposition'), end
        kk=kk+1;
    end
end
print('-dpng',['spectral2d_r', num2str(r),'_k', num2str(k),'_d',num2str(d),'_n',num2str(n)])

%% plot optimal linear embedding in 3d
figure(4), clf,
for ll=1:k,
    subplot(221), hold on
    plot3(v(n*(ll-1)+1:ll*n,1),v(n*(ll-1)+1:ll*n,2),v(n*(ll-1)+1:ll*n,3),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('1'), ylabel('2'), zlabel('3')
    subplot(222), hold on
    plot3(v(n*(ll-1)+1:ll*n,1),v(n*(ll-1)+1:ll*n,2),v(n*(ll-1)+1:ll*n,4),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('1'), ylabel('2'), zlabel('4')
    subplot(223), hold on
    plot3(v(n*(ll-1)+1:ll*n,1),v(n*(ll-1)+1:ll*n,3),v(n*(ll-1)+1:ll*n,4),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('1'), ylabel('3'), zlabel('4')
    subplot(224), hold on
    plot3(v(n*(ll-1)+1:ll*n,2),v(n*(ll-1)+1:ll*n,3),v(n*(ll-1)+1:ll*n,4),...
        '.','MarkerEdgeColor',colors{ll},'MarkerFaceColor',colors{ll}), grid on
    xlabel('2'), ylabel('3'), zlabel('4')
end
print('-dpng',['spectral3d_r', num2str(r),'_k', num2str(k),'_d',num2str(d),'_n',num2str(n)])


%%
% figure(5), clf
% for j=1:kr
%     subplot(r,k,j),
%     if j>
%
%     plot3(v(:,1),v(:,2),v(:,3),'r.')
% end