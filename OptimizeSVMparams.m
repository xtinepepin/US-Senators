function [acc, c_opt, g_opt] = OptimizeSVMparams(train_data, train_labels)

% Function that optimizes the SVM parameters given the (normalized) 
% training data matrix and label vector.
% The parameters are the cost c and the gamma coefficient of the Gaussian
% kernel. They are optimized by sweeping through multiple values of c and 
% gamma and keeping the ones yielding maximum (ten-fold) cross-validation 
% accuracy. The outputs are the cross-validation accuracy, the optimal 
% cost, and the optimal gamma.

MAX = 0.0;

c_vec = [0.05 0.1 0.5 1 5 10 15 20 50 100];
g_vec = [0.001 0.005 0.01 0.06 0.1 0.4 0.8 1.5];

tic
% Loops over c and gamma values
for c = c_vec
    for g = g_vec
        model = svmtrain(train_labels, train_data, ...
             ['-s 0 -t 2 -g ' num2str(g) ' -c ' num2str(c) ' -b 1 -v 10 -q']); 
        if (model >= MAX)
            MAX = model;
            c_opt = c;
            g_opt = g;
        end        
    end
end
acc = MAX;
toc

end

