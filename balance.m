function balance(paciente)
    if(strcmp(paciente,'92202'))
        f92202 = load('92202.mat');
        feat = f92202.FeatVectSel;
        feat = transpose(feat);
        trg = f92202.Trg;
    else
        f54802 = load('54802.mat');
        f54802c = load('54802_corrected_Trg.mat');
        feat = f54802.FeatVectSel;
        feat = transpose(feat);
        trg = f54802c.Trg;
    end
    
    trgSize = length(trg);
    newTrg = zeros(4, trgSize);
    i=1;
    [l,c] = size(trg);
    lsmt = zeros(l,c);
    while i <= trgSize
        if trg(i) == 0
            lsmt(i) = 1;
            newTrg(:,i) = [1, 0, 0, 0];
            i = i+1;
        else
            for j = i-600:i-1
                lsmt(j) = 2;
                newTrg(:,j) = [0, 1, 0, 0];
            end
            
            while i <= trgSize && trg(i) ~=0
                lsmt(i) = 3;
                newTrg(:,i) = [0, 0, 1, 0];
                i = i+1;
            end
            for j=i:i+300
                lsmt(j) = 4;
                newTrg(:,j) = [0, 0, 0, 1];
            end
            i = i+300;
         end
    end
    
    save('lsmt','lsmt');
     
    
    %Dividir teste e treino
    convulsoes = diff(trg);
    %instante de inicio do preictal da convulsao
    inicioConv = find(convulsoes==1)-600;
    %instante de fim do posictal da convulsao
    fimConv = find(convulsoes==-1)+300;
    numeroConvulsoes = length(inicioConv);
    percentagemTreino = round(numeroConvulsoes * 0.7);
    convulsoesPos = [];
    for i=1:percentagemTreino
        convulsoesPos = [convulsoesPos inicioConv(i):1:fimConv(i)];
      
    end
    convulsoesPos
    
    interIctalPos = find(newTrg(1,:)==1);
    interIctalPos = interIctalPos(randperm(length(interIctalPos)));
    tam = length(convulsoesPos);
    interIctalPos = interIctalPos(1:tam);
    %interIctalPos = sort(interIctalPos,'descend');
    treinoPos = horzcat(interIctalPos ,convulsoesPos);
    treinoPos = sort(treinoPos);
    
    treinoFeat = feat(:,treinoPos);
    treinoTrg = newTrg(:,treinoPos);
    
    lsmtOutput = lsmt(treinoPos,:);
    lsmtInput = feat(:,treinoPos);
    
    pos = 1:length(feat);
    testePos = setdiff(pos, treinoPos);
    
    testeFeat = feat(:,testePos);
    testeTrg = newTrg(:,testePos);
    
    lsmtOutputTest = lsmt(testePos,:);
    lsmtInputTest = feat(:,testePos);
    
    save('lsmtOutput', 'lsmtOutput');
    save('lsmtInput', 'lsmtInput');
    save('lsmtOutputTest', 'lsmtOutputTest');
    save('lsmtInputTest', 'lsmtInputTest');
    save('treinoFeat', 'treinoFeat');
    save('treinoTrg', 'treinoTrg');
    save('testeFeat', 'testeFeat');
    save('testeTrg', 'testeTrg');