function [sP,sD,eP,eD] = LSMTTest

    net = load('netLsmt.mat');
    net = net.netLsmt;
    lsmtOutputTest = load('lsmtOutputTest.mat');
    lsmtOutputTest = lsmtOutputTest.lsmtOutputTest;
    lsmtInputTest = load('lsmtInputTest.mat');
    lsmtInputTest = lsmtInputTest.lsmtInputTest;
    TrgCat=categorical(lsmtOutputTest);
    %categories(TrgCat);
    YTest=TrgCat;
    XTest = num2cell(lsmtInputTest,1);
    XTest = transpose(XTest);

    miniBatchSize = 27;
    YPred = classify(net,XTest, ...
        'MiniBatchSize',miniBatchSize, ...
        'SequenceLength','longest');
    
    
     %sensibilidade e especificidade
     tpp = 0;
     tnp = 0;
     fpp = 0;
     fnp = 0;
     tpd = 0;
     tnd = 0;
     fpd = 0;
     fnd = 0;
       
     YPred = double(YPred);
     YTest = double(YTest);
     for i= 1:size(YTest,1)
        t = YPred(i,:);
        targ = YTest(i,:);
        %pre-ictal
        if t==targ
            if t==2
                tpp = tpp+1;
            else
                tnp = tnp+1;
            end
        else
           if t==2
               fpp = fpp+1;
           else
               fnp = fnp+1;
           end
        end
         
        %ictal
        if t==targ
            if t==3
                tpd = tpd+1;
            else
                tnd = tnd+1;
            end
        else
            if t==3
                fpd = fpd+1;
            else
                fnd = fnd+1;
            end
        end
     end
        
     sP = num2str(round(((tpp / (tpp + fnp)) * 100), 2));
     sD = num2str(round(((tpd / (tpd + fnd)) * 100), 2));
     eP = num2str(round(((tnp / (tnp + fpp)) * 100), 2));
     eD = num2str(round(((tnd / (tnd + fpd)) * 100), 2));               
end