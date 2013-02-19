clc; clear; %close all;

%% small sparse graph
% constants
n = 200;
d = 2;

% parameters
mu0 = [0.8, 0.4]/4; % mean 0
mu1 = [0.2, 0.5]/2; % mean 1
mu = [mu0, mu1];

sigma = 0.04; % stan dev

% generate graph
[A, X, X0, X1, P] = GenerateGraph(n,d,mu,sigma);
plotGraph

%% large sparse graph
% constants
n = 5000;
d = 2;

% parameters
mu0 = [0.8, 0.4]/4; % mean 0
mu1 = [0.2, 0.5]/2; % mean 1
mu = [mu0, mu1];

sigma = 0.04; % stan dev

% generate graph
[A, X, X0, X1, P] = GenerateGraph(n,d,mu,sigma);
plotGraph

%% small subspace graph

n=100;     % number of samples
r=1;        % rank of *each* subspace
k=2;        % number of subspaces
c=0;        % mean shift of subspaces
kr=k*r;     % sum of ranks
d=2;       % ambient dimension
if d<kr, display('dim is too small'), break, end;

% generate data
U={};
data=[];
for i=1:k
    U{i}=orth(randn(d,r));
    Y{i}=U{i}*(c*randn(r,1)*ones(1,n)+randn(r,n));
    Y{i}=Y{i}-repmat(min(Y{i}'),n,1)';
    Y{i}=Y{i}/max(1.5*abs(Y{i}(:)));
    data=[data Y{i}];
end
P=(data'*data);
[max(P(:)), min(P(:))]

A=double(P>rand(n*k,n*k)); % adjacency matrix
A=tril(A,-1);
A=A'+A; % symmetric adjacency matrix

[U, D] = eigs(A,2); % eigen decomposition
% [Q,R,E] = qr(A); % rank-revealing QR

% latent positions
figure, clf, hold on
subplot(121), hold on
plot(Y{1}(1,:),Y{1}(2,:),'ro')
plot(Y{2}(1,:),Y{2}(2,:),'bx')
theta = linspace(-8*pi,8*pi,200);
plot(sin(theta),cos(theta),'k')
axis([0 1 0 1])
legend('0','1')


% embeddings embeddings
% figure(3), clf, hold on
subplot(122), hold on
plot(U(1:n/2,1),U(1:n/2,2),'ro')
plot(U(n/2+1:end,1),U(n/2+1:end,2),'bx')



%% large subspace graph

n=2500;     % number of samples
r=1;        % rank of *each* subspace
k=2;        % number of subspaces
c=0;        % mean shift of subspaces
kr=k*r;     % sum of ranks
d=2;       % ambient dimension
if d<kr, display('dim is too small'), break, end;

% generate data
U={};
data=[];
for i=1:k
    U{i}=orth(randn(d,r));
    Y{i}=U{i}*(c*randn(r,1)*ones(1,n)+randn(r,n));
    Y{i}=Y{i}-repmat(min(Y{i}'),n,1)';
    Y{i}=Y{i}/max(1.5*abs(Y{i}(:)));
    data=[data Y{i}];
end
P=(data'*data);
[max(P(:)), min(P(:))]

A=double(P>rand(n*k,n*k)); % adjacency matrix
A=tril(A,-1);
A=A'+A; % symmetric adjacency matrix

[U, D] = eigs(A,2); % eigen decomposition
% [Q,R,E] = qr(A); % rank-revealing QR

% latent positions
figure, clf, hold on
subplot(121), hold on
plot(Y{1}(1,:),Y{1}(2,:),'ro')
plot(Y{2}(1,:),Y{2}(2,:),'bx')
theta = linspace(-8*pi,8*pi,200);
plot(sin(theta),cos(theta),'k')
% axis([0 1 0 1])
legend('0','1')


% embeddings embeddings
% figure(3), clf, hold on
subplot(122), hold on
plot(U(1:n/2,1),U(1:n/2,2),'ro')
plot(U(n/2+1:end,1),U(n/2+1:end,2),'bx')



