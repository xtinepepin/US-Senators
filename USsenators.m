% Script that classifies US senators as Democrat or Republican according to
% 15 votes.

%% Read csv file and create data matrix and labels from table
filename = '114_congress.csv';
T = readtable(filename);
M = T{:, {'x00001', 'x00004', 'x00005', 'x00006', 'x00007', 'x00008',...
    'x00009', 'x00010', 'x00020', 'x00026', 'x00032', 'x00038',...
    'x00039', 'x00044', 'x00047'}};
Labels = T.party;
nrows = length(Labels);

%% Separate training data and test data
% I noticed that 75% of training data was needed to get 100% CV accuracy.
I = []; % vector of indices corresponding to independent senators
for i = 1:nrows
    if (Labels{i,1} == 'I')
        I = [I; i];
    end
end

% Do not use I senators for training! But use them for testing.
train_ind = [(1:I(1)-1) (I(1)+1):76];
num_train_data = length(train_ind);
train_data = M(train_ind, :); 
train_labels = [];
for i = train_ind
    if (Labels{i,1} == 'D')
        train_labels = [train_labels; 1];
    else
        train_labels = [train_labels; 0];
    end
end

test_ind = [I(1) (77:nrows)];
num_test_data = length(test_ind);
test_data =  M(test_ind, :); 
test_labels = [];
for i = test_ind
    if (Labels{i,1} == 'D')
        test_labels = [test_labels; 1];
    elseif (Labels{i,1} == 'R')
        test_labels = [test_labels; 0];
    else % classify Independent as Democrats by default
        test_labels = [test_labels; 1];
    end
end
    
%% Normalize data
mu_train = mean(train_data);
sigma_train = std(train_data);
train_data_norm = (train_data - repmat(mu_train, num_train_data, 1)) ...
    .*(repmat(sigma_train.^(-1), num_train_data, 1));   

mu_test = mean(test_data);
sigma_test = std(test_data);
test_data_norm = (test_data - repmat(mu_test, num_test_data, 1)) ...
    .*(repmat(sigma_test.^(-1), num_test_data, 1));
        
%% Optimize SVM parameters using cross-validation
[acc, c_opt, g_opt] = OptimizeSVMparams(train_data_norm, train_labels);

%% Predict test labels
[predict_label] = PredictLabels(train_data_norm, train_labels, ...
    test_data_norm, test_labels, c_opt, g_opt);

        