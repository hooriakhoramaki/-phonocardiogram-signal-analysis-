function  SimpleNuraulnetwork(Top_feature_s1,Top_feature_s2,Top_feature_systol,Top_feature_diastol)

Top_feature_s1 = Top_feature_s1(~any(isnan(Top_feature_s1), 2), :);  % حذف سطرهای دارای NaN
Top_feature_s2 = Top_feature_s2(~any(isnan(Top_feature_s2), 2), :);  % حذف سطرهای دارای NaN
Top_feature_systol = Top_feature_systol(~any(isnan(Top_feature_systol), 2), :);  % حذف سطرهای دارای NaN
Top_feature_diastol = Top_feature_diastol(~any(isnan(Top_feature_diastol), 2), :);  % حذف سطرهای دارای NaN

features=[Top_feature_s1(1:end-1, 1:end-1) ;Top_feature_s2(1:end-1, 1:end-1) ; Top_feature_systol(1:end-1, 1:end-1) ;Top_feature_diastol(1:end-1, 1:end-1) ];
labels =[Top_feature_s1(:,end) ; Top_feature_s2(:,end) ; Top_feature_systol(: , end) ; Top_feature_diastol(:,end)];


% labels(labels == -1) = 0;
% تعداد ویژگی‌ها و نمونه‌ها
[num_samples, num_features] = size(features);

% تقسیم داده‌ها به مجموعه آموزش و آزمایش
train_ratio = 0.8;
idx = randperm(num_samples);
train_idx = idx(1:round(train_ratio * num_samples));
test_idx = idx(round(train_ratio * num_samples) + 1:end);

X_train = features(train_idx, :);
y_train = labels(train_idx);

X_test = features(test_idx, :);
y_test = labels(test_idx);

% تعریف لایه‌های شبکه MLP ساده
layers = [
    featureInputLayer(num_features, 'Name', 'input')
    fullyConnectedLayer(32, 'Name', 'fc1')  % لایه مخفی اول با 32 نورون
    reluLayer('Name', 'tanh1')              % تابع فعال‌سازی ReLU
    fullyConnectedLayer(16, 'Name', 'fc2')  % لایه مخفی دوم با 16 نورون
    reluLayer('Name', 'tanh2')  
    fullyConnectedLayer(2, 'Name', 'fc3')   % لایه خروجی (دو کلاس)
    softmaxLayer('Name', 'sigmoid')  
    classificationLayer('Name', 'output')];


% تنظیمات آموزش
options = trainingOptions('adam', ...
    'MaxEpochs', 30, ...          % ۳۰ دوره آموزش
    'MiniBatchSize', 32, ...      % دسته‌های کوچک ۳۲ نمونه‌ای
    'InitialLearnRate', 1e-3, ... % نرخ یادگیری
    'ValidationData', {X_test, categorical(y_test)}, ...
    'Plots', 'training-progress', ...
    'Verbose', false);

% آموزش شبکه
net = trainNetwork(X_train, categorical(y_train), layers, options);

% ارزیابی مدل
predictedLabels = classify(net, X_test);
accuracy = sum(predictedLabels == categorical(y_test)) / numel(y_test);
disp(['Accuracy: ', num2str(accuracy)]);

% محاسبه TP, TN, FP, FN
TP = sum((predictedLabels == '1') & (categorical(y_test) == '1'));
TN = sum((predictedLabels == '0') & (categorical(y_test) == '0'));
FP = sum((predictedLabels == '1') & (categorical(y_test) == '0'));
FN = sum((predictedLabels == '0') & (categorical(y_test) == '1'));

% نمایش نتایج
disp(['True Positives (TP): ', num2str(TP)]);
disp(['True Negatives (TN): ', num2str(TN)]);
disp(['False Positives (FP): ', num2str(FP)]);
disp(['False Negatives (FN): ', num2str(FN)]);

% محاسبه حساسیت و ویژگی
sensitivity = TP / (TP + FN); % همان Recall
specificity = TN / (TN + FP);
disp(['Sensitivity (Recall): ', num2str(sensitivity)]);
disp(['Specificity: ', num2str(specificity)]);

end

