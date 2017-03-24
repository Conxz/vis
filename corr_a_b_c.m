
N = 200;
r_list = 0.01:0.01:0.9;

N_repeat = 1000;

r_bc = zeros(length(r_list), length(r_list), N_repeat);

for k=1:N_repeat
    X = randn(N,1);
    Y = randn(N,1);
    Z = randn(N,1);
    A = X;
    i =1;
    for r_ab = r_list
        B = sqrt(r_ab^2)*X+sqrt(1-r_ab^2)*Y;
        j =1;
        for r_ac = r_list
            C = sqrt(r_ac^2)*X+sqrt(1-r_ac^2)*Z;
            tmp = corrcoef(B,C);
            r_bc(i,j,k) = tmp(1,2);
            j = j+1;
        end
        i=i+1;
    end
end

% plot the correlation changes with different pairs of first two
% correlations.
figure;
mean_r_bc = mean(r_bc, 3);
imagesc(r_list, r_list, mean_r_bc);
set(gca,'YDir','normal');
colorbar()
xlabel('A-B Correlation'); ylabel('A-C Correlation');
title('B-C Correlation Given A-B and A-C Correlation');
saveas(gcf,'Figure 1','png');

% plot distribution of the correlations given the first two correlation
% values. 
r_ab = 0.30;
r_ac = 0.80;
index_r_ab = find(r_list==r_ab);
index_r_ac = find(r_list==r_ac);
figure;
hist(reshape((r_bc(index_r_ab,index_r_ac,:)), N_repeat,1), 50);
xlabel('B-C Correlation'); ylabel('Frequency');
title('Distribution of B-C Correlations Given A-B and A-C');
saveas(gcf,sprintf('Figure 2_%.2f_%.2f.png', r_ab, r_ac));

save('rs_ab_ac_bc_variables', 'r_list', 'N_repeat', 'mean_r_bc', 'r_bc');

%% another similar method 
% chol is similar to B = sqrt(rho^2)*X+sqrt(1-rho^2)*Y;
%R = [1 r; r 1];
%M = M*chol(R); 
%x = M(:,1);
%y = M(:,2);
%corrcoef(x,y)