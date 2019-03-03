function [sP,sD,eP,eD] = test(rede)  %retornar especificidade e sensibilidade para a GUI
        newTrgB = load('testeTrg.mat');
        newTrgB = newTrgB.testeTrg;
        newFeatB = load('testeFeat.mat');
        newFeatB = newFeatB.testeFeat;
        endn = '.mat';
        rede2 = strcat(rede,endn);
        net2 = load(rede2);
        %net2 = load('net.mat');
        net2 = net2.net;
        T = sim(net2,newFeatB);
        %verificar que fase ictal foi detetada
        newT = zeros(4,size(T,2));
        for i=1:size(T,2)
            state = T(:,i);
            indice = 1;
            if(sum(state)==0)
                indice = -1;
            end
            newState = zeros(4,1);
            max = 0;
            for k=indice:4
                if(state(k)>max)
                    max = state(k);
                    indice = k;
                end
            end
            if(indice ~= -1)
               newState(indice) = 1; 
            end
            newT(:, i) = newState;
        end
        
        %sensibilidade e especificidade
        tpp = 0;
        tnp = 0;
        fpp = 0;
        fnp = 0;
        tpd = 0;
        tnd = 0;
        fpd = 0;
        fnd = 0;
       
        for i= 1:size(newTrgB,2)
            t = newT(:,i);
            targ = newTrgB(:,i);
            
            %pre-ictal
            if t(2)==targ(2)
                if t(2)==1
                    tpp = tpp+1;
                else
                    tnp = tnp+1;
                end
            else
                if t(2)==1
                    fpp = fpp+1;
                else
                    fnp = fnp+1;
                end
            end
            
            %ictal
            if t(3)==targ(3)
                if t(3)==1
                    tpd = tpd+1;
                else
                    tnd = tnd+1;
                end
            else
                if t(3)==1
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
    