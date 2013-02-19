clc; clear; %close all;
% constants
n = 100;
d = 2;

% parameters
mu0 = [0.8, 0.4]/2; % mean 0
mu1 = [0.2, 0.5]/2; % mean 1
mu = [mu0, mu1];

sigma = 0.04; % stan dev

% generate graph
[A, X, X0, X1, P] = GenerateGraph(n,d,mu,sigma);
plotGraph

% cluster vertices
numClusts = 2;
lambda = 1;
stepsize = 20;
numsteps = 100;

% [xhat, muhat, tauhat, cost] = gradientSearchNOPCA(P, d, numClusts, lambda, stepsize, numsteps);
% figure; plot(cost')
% mumu(tauhat==1,:)=repmat(muhat(1,:),sum(tauhat==1),1);
% mumu(tauhat==2,:)=repmat(muhat(2,:),sum(tauhat==2),1);
% cost1=norm(xhat-mumu,'fro')^2
% cost2=norm(A-xhat*xhat','fro')^2
