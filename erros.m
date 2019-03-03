function erros = erros(tipo)
    newTrgB = load('treinoTrg.mat');
    newTrgB = newTrgB.treinoTrg;
    [l,c] = size(newTrgB);
    erros = ones(1,c);
    if(~strcmp(tipo,'Sem'))
        interIctSum = sum(newTrgB(1,:));
        preIctSum = sum(newTrgB(2,:));
        ictSum = sum(newTrgB(3,:));

        for k=1:c
            new = newTrgB(:,k);
            if(new(2)==1 && strcmp(tipo,'Previsao'))
                erros(k) = (interIctSum/preIctSum)*1.10;
            end
            if(new(3)==1 && strcmp(tipo,'Deteccao'))
                erros(k) = (interIctSum/ictSum)*1.10;
            end
        end  
    end
end