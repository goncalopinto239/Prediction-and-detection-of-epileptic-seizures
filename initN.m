function net = initN(net,numeroLayers,tamanhoLayers,funcaoTreino,funcaoActivacao)
    net.numLayers = numeroLayers+1;
    net.numInputs = 1;
    net.inputs{1}.size = 29;
    for i = 1:numeroLayers
        net.layers{i}.transferFcn = funcaoActivacao;
        net.layers{i}.size = tamanhoLayers(i);
    end
    net.layers{numeroLayers+1}.size = 4;
    net.outputConnect(numeroLayers+1) = 1;
    net.divideFcn = 'divideblock';
    net.divideParam.trainRatio = 0.85;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0;
    net.trainParam.lr = 0.1;
    net.trainFcn = funcaoTreino;
    W=rand(tamanhoLayers(1),29);
    b=rand(tamanhoLayers(1),1);
    net.IW{1,1}=W;
    net.b{1,1}=b;
    
end