function LSMT

    lsmtOutput = load('lsmtOutput.mat');
    lsmtOutput = lsmtOutput.lsmtOutput;
    lsmtInput = load('lsmtInput.mat');
    lsmtInput = lsmtInput.lsmtInput;
    TrgCat=categorical(lsmtOutput);
    %categories(TrgCat);
    YTrain=TrgCat;
    XTrain = num2cell(lsmtInput,1);
    XTrain = transpose(XTrain);
    
    inputSize = 29;
    numHiddenUnits = 100;
    numClasses = 4;
 
    layers = [ ...
        sequenceInputLayer(inputSize)
        bilstmLayer(numHiddenUnits,'OutputMode','last')
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];
    
    maxEpochs = 25;
    miniBatchSize = 27;

    options = trainingOptions('adam', ...
        'ExecutionEnvironment','cpu', ...
        'GradientThreshold',1, ...
        'MaxEpochs',maxEpochs, ...
        'MiniBatchSize',miniBatchSize, ...
        'SequenceLength','longest', ...
        'Shuffle','never', ...
        'Verbose',0, ...
        'Plots','training-progress');
    
    netLsmt = trainNetwork(XTrain,YTrain,layers,options);
    save('netLsmt','netLsmt');
end