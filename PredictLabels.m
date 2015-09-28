function [predict_label] = PredictLabels(train_data, train_labels, ...
    test_data, test_label, c_opt, g_opt)

% Train model with optimum SVM parameters
model = svmtrain(train_labels, train_data, ...
    ['-s 0 -t 2 -g ' num2str(g_opt) ' -c ' num2str(c_opt) ' -b 1 -q']);

disp('Done building SVM model');

% Predict test labels
[predict_label] = svmpredict(test_label, test_data, model, '-b 1');

disp('Done predicting labels');

end