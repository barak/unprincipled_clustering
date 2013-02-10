%% set simulation parameters
clc; clear all;
n=100;     % number of samples
r=2;        % rank of *each* subspace
k=3;        % number of subspaces
c=0;        % mean shift of subspaces
kr=k*r;     % sum of ranks
d=10;   % ambient dimension
if d<kr, display('dim is too small'), break, end;

%% generate data
U={};
data=[];
for i=1:k
    U{i}=orth(randn(d,r));
    if i==2,
        U{i}=0.1*randn(d,r)+U{1};
        U{i}=orth(U{i});
    end
    Y{i}=U{i}*(c*randn(r,1)*ones(1,n)+randn(r,n));
    data=[data Y{i}];
end

% project data on true low-dimensional subspaces
UU=[];
for i=1:k
    UU=[UU U{i}];
end
proj = (UU\data)';

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
% WARNING: note that this makes nchoosek(kr,3) plots!!!!

nplots=nchoosek(kr,3); 
factors=factor(nplots);
nrows=prod(factors(1:length(factors)-1));
ncols=factors(end);
figure(2), clf
ll=0;
for ii=1:kr-2
    for jj=ii+1:kr-1
        for kk=jj+1:kr
            ll=ll+1;
            subplot(nrows,ncols,ll),  grid on, hold on
            for mm=1:k
                plot3(proj(n*(mm-1)+1:mm*n,ii),proj(n*(mm-1)+1:mm*n,jj),proj(n*(mm-1)+1:mm*n,kk),...
                    '.','MarkerEdgeColor',colors{mm},'MarkerFaceColor',colors{mm}),
            end
            xlabel(num2str(ii)), ylabel(num2str(jj)), zlabel(num2str(kk))
            set(gca,'XTick',[],'YTick',[])
        end
    end
end
print('-dpng',['true3d_r', num2str(r),'_k', num2str(k),'_d',num2str(d),'_n',num2str(n)])


%% find optimal linear embedding and plot
options.disp=1;
[uu ss vv] = svds(data,kr); %,10^9,options);
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
% WARNING: note that this makes nchoosek(kr,3) plots!!!!


nplots=nchoosek(kr,3); 
factors=factor(nplots);
nrows=prod(factors(1:length(factors)-1));
ncols=factors(end);
figure(4), clf
ll=0;
for ii=1:kr-2
    for jj=ii+1:kr-1
        for kk=jj+1:kr
            ll=ll+1;
            subplot(nrows,ncols,ll),  grid on, hold on
            for mm=1:k
                plot3(v(n*(mm-1)+1:mm*n,ii),v(n*(mm-1)+1:mm*n,jj),v(n*(mm-1)+1:mm*n,kk),...
                    '.','MarkerEdgeColor',colors{mm},'MarkerFaceColor',colors{mm}),
            end
            xlabel(num2str(ii)), ylabel(num2str(jj)), zlabel(num2str(kk))
            set(gca,'XTick',[],'YTick',[])
        end
    end
end
print('-dpng',['spectral3d_r', num2str(r),'_k', num2str(k),'_d',num2str(d),'_n',num2str(n)])