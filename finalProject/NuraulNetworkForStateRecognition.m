function [] = NuraulNetworkForStateRecognition(Top_feature_s1,Top_feature_s2,Top_feature_systol,Top_feature_diastol)
Top_feature_s1 = Top_feature_s1(~any(isnan(Top_feature_s1), 2), :);  % حذف سطرهای دارای NaN
Top_feature_s2 = Top_feature_s2(~any(isnan(Top_feature_s2), 2), :);  % حذف سطرهای دارای NaN
Top_feature_systol = Top_feature_systol(~any(isnan(Top_feature_systol), 2), :);  % حذف سطرهای دارای NaN
Top_feature_diastol = Top_feature_diastol(~any(isnan(Top_feature_diastol), 2), :);  % حذف سطرهای دارای NaN




all_features=[Top_feature_s1(1:end-1, 1:end-1) ;Top_feature_s2(1:end-1, 1:end-1) ; Top_feature_systol(1:end-1, 1:end-1) ;Top_feature_diastol(1:end-1, 1:end-1) ];
labels =[Top_feature_s1(:,end) ; Top_feature_s2(:,end) ; Top_feature_systol(: , end) ; Top_feature_diastol(:,end)];
labels(labels == -1) = 0;

num_samples = size(all_features, 1);
idx = randperm(num_samples);
train_ratio = 0.8;


train_idx = idx(1:round(train_ratio * num_samples));
test_idx = idx(round(train_ratio * num_samples) + 1:end);

X_train = all_features(train_idx, :);
%y_train = labels(train_idx);
y_train = labels(train_idx);

X_test = all_features(test_idx, :);
%y_test = labels(test_idx);
y_test = labels(test_idx);


input_size = size(all_features, 2); % تعداد ویژگی‌ها
layers = [
    featureInputLayer(input_size, 'Name', 'input')
    fullyConnectedLayer(64, 'Name', 'fc1')  % لایه Fully Connected
    reluLayer('Name', 'relu1')              % تابع فعال‌سازی
    dropoutLayer(0.3, 'Name', 'dropout1')   % Dropout برای جلوگیری از Overfitting
    fullyConnectedLayer(32, 'Name', 'fc2')
    reluLayer('Name', 'relu2')
    dropoutLayer(0.3, 'Name', 'dropout2')
    fullyConnectedLayer(2, 'Name', 'fc3')  % دو کلاس: نرمال یا غیرنرمال
    softmaxLayer('Name', 'softmax')
    classificationLayer('Name', 'output')];

% تنظیمات آموزش:
options = trainingOptions('adam', ...
    'MaxEpochs', 50, ...
    'InitialLearnRate', 1e-3, ...
    'MiniBatchSize', 16, ...
    'ValidationData', {X_test, categorical(y_test)}, ...
    'ValidationFrequency', 10, ...
    'Plots', 'training-progress', ...
    'Verbose', false);

% آموزش شبکه:
net = trainNetwork(X_train, categorical(y_train), layers, options);

% ارزیابی مدل:
predictedLabels = classify(net, X_test);
accuracy = sum(predictedLabels == categorical(y_test)) / numel(y_test);
disp(['Accuracy: ', num2str(accuracy)]);

% محاسبه حساسیت و ویژگی:
TP = sum((predictedLabels == '1') & (categorical(y_test) == '1'));
TN = sum((predictedLabels == '0') & (categorical(y_test) == '0'));
FP = sum((predictedLabels == '1') & (categorical(y_test) == '0'));
FN = sum((predictedLabels == '0') & (categorical(y_test) == '1'));
% نمایش نتایج
disp(['True Positives (TP): ', num2str(TP)]);
disp(['True Negatives (TN): ', num2str(TN)]);
disp(['False Positives (FP): ', num2str(FP)]);
disp(['False Negatives (FN): ', num2str(FN)]);

sensitivity = TP / (TP + FN);
specificity = TN / (TN + FP);
disp(['Sensitivity: ', num2str(sensitivity)]);
disp(['Specificity: ', num2str(specificity)]);

end