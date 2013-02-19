[U, D] = eigs(A,2); % eigen decomposition
% [Q,R,E] = qr(A); % rank-revealing QR

% latent positions
figure, clf, hold on
subplot(121), hold on
plot(X0(:,1),X0(:,2),'ro')
plot(X1(:,1),X1(:,2),'bx')
theta = linspace(-8*pi,8*pi,200);
plot(sin(theta),cos(theta),'k')
axis([0 1 0 1])
legend('0','1')


% embeddings embeddings
% figure(3), clf, hold on
subplot(122), hold on
plot(U(1:n/2,1),U(1:n/2,2),'ro')
plot(U(n/2+1:end,1),U(n/2+1:end,2),'bx')

% % P matrix and A matrix
% figure, clf,
% subplot(121), imagesc(X*X'), colormap('gray'), axis('square'), %n/2+1:end
% if any(P(:)<0) || any(P(:)>1),
%     display('some P are impossible'),
% else display('all P are good')
% end
% subplot(122), spy(A,5)

% subplot(122), hold on
% plot(Q(1:n/2,1),Q(1:n/2,2),'ro')
% plot(Q(n/2+1:end,1),Q(n/2+1:end,2),'bx')





