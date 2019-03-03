function train(arquitetura,aprendizagem,funcaoActivacao,funcaoTreino,funcaoAprendizagem,delayStart,delayEnd,numeroLayers,tamanhoLayer,erros) %falta colocar parametro paciente
    newTrgB = load('treinoTrg.mat');
    newTrgB = newTrgB.treinoTrg;
    newFeatB = load('TreinoFeat.mat');
    newFeatB = newFeatB.treinoFeat;
    tamanhoLayers = zeros(1,numeroLayers);
    for i=1 :numeroLayers
        tamanhoLayers(i) = tamanhoLayer;
    end
    if(strcmp(arquitetura,"Feedforwardnet"))
        if(strcmp(aprendizagem,"Batch"))
            net = feedforwardnet(tamanhoLayers);
            net = initN(net,numeroLayers,tamanhoLayers,funcaoTreino,funcaoActivacao);
            net = train(net, newFeatB, newTrgB, [],[],erros);
        else
            net = feedforwardnet(tamanhoLayers);
            net = initN(net,numeroLayers,tamanhoLayers,funcaoTreino,funcaoActivacao);
            for i = 1:numeroLayers
                net.inputWeights{1}.learnFcn = funcaoAprendizagem;
                net.biases{1}.learnFcn = funcaoAprendizagem;
            end
            net = train(net, newFeatB, newTrgB, [],[],erros);
        end
    else
        if(strcmp(aprendizagem,"Batch"))
            net = layrecnet(delayStart:delayEnd,tamanhoLayers);
            net = initN(net,numeroLayers,tamanhoLayers,funcaoTreino,funcaoActivacao);
            net = train(net, newFeatB, newTrgB, [],[],erros);
            
        else
            net = layrecnet(delayStart:delayEnd,tamanhoLayers);
            net = initN(net,numeroLayers,tamanhoLayers,funcaoTreino,funcaoActivacao);
            for i = 1:numeroLayers
                net.inputWeights{1}.learnFcn = funcaoAprendizagem;
                net.biases{1}.learnFcn = funcaoAprendizagem;
            end
            net = train(net, newFeatB, newTrgB, [],[],erros);
        end
    end
    save net net
end