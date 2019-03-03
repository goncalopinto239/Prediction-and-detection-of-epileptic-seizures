function CNN

    [XTrain,YTrain] = prepareXTrain(1);
    
    layers = [
        imageInputLayer([29 29 1])
    
        convolution2dLayer(3,8,'Padding','same')
        batchNormalizationLayer
        reluLayer
    
        maxPooling2dLayer(2,'Stride',2)
    
        convolution2dLayer(3,16,'Padding','same')
        batchNormalizationLayer
        reluLayer
    
        maxPooling2dLayer(2,'Stride',2)
    
        convolution2dLayer(3,32,'Padding','same')
        batchNormalizationLayer
        reluLayer
    
        fullyConnectedLayer(4)
        softmaxLayer
        classificationLayer];
    
    options = trainingOptions('sgdm', ...
        'InitialLearnRate',0.1, ...
        'MaxEpochs',100, ...
        'Shuffle','every-epoch', ...
        'Verbose',false, ...
        'Plots','training-progress');
    
    netCNN = trainNetwork(XTrain,YTrain,layers,options);
    save('netCNN','netCNN');
end