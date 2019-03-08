function [trainedClassifier, validationAccuracy] = s7m_trainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationAccuracy: a double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 05-Mar-2019 17:22:01


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'IAV_ch1', 'IAV_ch2', 'IAV_ch3', 'IAV_ch4', 'IAV_ch5', 'IAV_ch6', 'IAV_ch7', 'IAV_ch8', 'IAV_ch9', 'IAV_ch10', 'nIAV_ch1', 'nIAV_ch2', 'nIAV_ch3', 'nIAV_ch4', 'nIAV_ch5', 'nIAV_ch6', 'nIAV_ch7', 'nIAV_ch8', 'nIAV_ch9', 'nIAV_ch10', 'MAV_ch1', 'MAV_ch2', 'MAV_ch3', 'MAV_ch4', 'MAV_ch5', 'MAV_ch6', 'MAV_ch7', 'MAV_ch8', 'MAV_ch9', 'MAV_ch10', 'nMAV_ch1', 'nMAV_ch2', 'nMAV_ch3', 'nMAV_ch4', 'nMAV_ch5', 'nMAV_ch6', 'nMAV_ch7', 'nMAV_ch8', 'nMAV_ch9', 'nMAV_ch10', 'RMS_ch1', 'RMS_ch2', 'RMS_ch3', 'RMS_ch4', 'RMS_ch5', 'RMS_ch6', 'RMS_ch7', 'RMS_ch8', 'RMS_ch9', 'RMS_ch10', 'nRMS_ch1', 'nRMS_ch2', 'nRMS_ch3', 'nRMS_ch4', 'nRMS_ch5', 'nRMS_ch6', 'nRMS_ch7', 'nRMS_ch8', 'nRMS_ch9', 'nRMS_ch10', 'WL_ch1', 'WL_ch2', 'WL_ch3', 'WL_ch4', 'WL_ch5', 'WL_ch6', 'WL_ch7', 'WL_ch8', 'WL_ch9', 'WL_ch10', 'nWL_ch1', 'nWL_ch2', 'nWL_ch3', 'nWL_ch4', 'nWL_ch5', 'nWL_ch6', 'nWL_ch7', 'nWL_ch8', 'nWL_ch9', 'nWL_ch10'};
predictors = inputTable(:, predictorNames);
response = inputTable.C;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateSVM(...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 4.8, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', {'Class1'; 'Class10'; 'Class11'; 'Class12'; 'Class2'; 'Class3'; 'Class4'; 'Class5'; 'Class6'; 'Class7'; 'Class8'; 'Class9'});

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'IAV_ch1', 'IAV_ch10', 'IAV_ch2', 'IAV_ch3', 'IAV_ch4', 'IAV_ch5', 'IAV_ch6', 'IAV_ch7', 'IAV_ch8', 'IAV_ch9', 'MAV_ch1', 'MAV_ch10', 'MAV_ch2', 'MAV_ch3', 'MAV_ch4', 'MAV_ch5', 'MAV_ch6', 'MAV_ch7', 'MAV_ch8', 'MAV_ch9', 'RMS_ch1', 'RMS_ch10', 'RMS_ch2', 'RMS_ch3', 'RMS_ch4', 'RMS_ch5', 'RMS_ch6', 'RMS_ch7', 'RMS_ch8', 'RMS_ch9', 'WL_ch1', 'WL_ch10', 'WL_ch2', 'WL_ch3', 'WL_ch4', 'WL_ch5', 'WL_ch6', 'WL_ch7', 'WL_ch8', 'WL_ch9', 'nIAV_ch1', 'nIAV_ch10', 'nIAV_ch2', 'nIAV_ch3', 'nIAV_ch4', 'nIAV_ch5', 'nIAV_ch6', 'nIAV_ch7', 'nIAV_ch8', 'nIAV_ch9', 'nMAV_ch1', 'nMAV_ch10', 'nMAV_ch2', 'nMAV_ch3', 'nMAV_ch4', 'nMAV_ch5', 'nMAV_ch6', 'nMAV_ch7', 'nMAV_ch8', 'nMAV_ch9', 'nRMS_ch1', 'nRMS_ch10', 'nRMS_ch2', 'nRMS_ch3', 'nRMS_ch4', 'nRMS_ch5', 'nRMS_ch6', 'nRMS_ch7', 'nRMS_ch8', 'nRMS_ch9', 'nWL_ch1', 'nWL_ch10', 'nWL_ch2', 'nWL_ch3', 'nWL_ch4', 'nWL_ch5', 'nWL_ch6', 'nWL_ch7', 'nWL_ch8', 'nWL_ch9'};
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2019a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'IAV_ch1', 'IAV_ch2', 'IAV_ch3', 'IAV_ch4', 'IAV_ch5', 'IAV_ch6', 'IAV_ch7', 'IAV_ch8', 'IAV_ch9', 'IAV_ch10', 'nIAV_ch1', 'nIAV_ch2', 'nIAV_ch3', 'nIAV_ch4', 'nIAV_ch5', 'nIAV_ch6', 'nIAV_ch7', 'nIAV_ch8', 'nIAV_ch9', 'nIAV_ch10', 'MAV_ch1', 'MAV_ch2', 'MAV_ch3', 'MAV_ch4', 'MAV_ch5', 'MAV_ch6', 'MAV_ch7', 'MAV_ch8', 'MAV_ch9', 'MAV_ch10', 'nMAV_ch1', 'nMAV_ch2', 'nMAV_ch3', 'nMAV_ch4', 'nMAV_ch5', 'nMAV_ch6', 'nMAV_ch7', 'nMAV_ch8', 'nMAV_ch9', 'nMAV_ch10', 'RMS_ch1', 'RMS_ch2', 'RMS_ch3', 'RMS_ch4', 'RMS_ch5', 'RMS_ch6', 'RMS_ch7', 'RMS_ch8', 'RMS_ch9', 'RMS_ch10', 'nRMS_ch1', 'nRMS_ch2', 'nRMS_ch3', 'nRMS_ch4', 'nRMS_ch5', 'nRMS_ch6', 'nRMS_ch7', 'nRMS_ch8', 'nRMS_ch9', 'nRMS_ch10', 'WL_ch1', 'WL_ch2', 'WL_ch3', 'WL_ch4', 'WL_ch5', 'WL_ch6', 'WL_ch7', 'WL_ch8', 'WL_ch9', 'WL_ch10', 'nWL_ch1', 'nWL_ch2', 'nWL_ch3', 'nWL_ch4', 'nWL_ch5', 'nWL_ch6', 'nWL_ch7', 'nWL_ch8', 'nWL_ch9', 'nWL_ch10'};
predictors = inputTable(:, predictorNames);
response = inputTable.C;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 10);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
