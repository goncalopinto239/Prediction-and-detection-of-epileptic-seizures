function [XTrain,YTrain] = prepareXTrain(func)
    if func==1
        treinoFeat = load('treinoFeat.mat');
        treinoFeat = treinoFeat.treinoFeat;
        treinoTrg = load('lsmtOutput.mat');
        treinoTrg = treinoTrg.lsmtOutput;
    else
        treinoFeat = load('testeFeat.mat');
        treinoFeat = treinoFeat.testeFeat;
        treinoTrg = load('lsmtOutputTest.mat');
        treinoTrg = treinoTrg.lsmtOutputTest;
    end
    numberOfImages = round(size(treinoFeat,2)/29);
    XTrain = zeros(29,29,1,numberOfImages);
    YTrain = zeros(1,numberOfImages);
    i = 1;
    pos = 1;
    while i+28 < size(treinoFeat,2)
        inp = treinoFeat(:,i:i+28);
        trg = treinoTrg(i:i+28,:);
        state = find(trg ~= trg(1));
        if isempty(state)
            XTrain(:,:,:,pos) = inp;
            YTrain(pos) = trg(1);
            pos = pos+1;
        end
        i = i+29;
    end
    XTrain = XTrain(:,:,:,1:pos-1);
    YTrain = YTrain(:,1:pos-1);
    YTrain = categorical(YTrain);
end