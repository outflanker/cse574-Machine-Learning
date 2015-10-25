function [M_cfs,ErmsMin,Lam] = train_cfs(ModelLim,Lambda,S)
    load project1_data.mat;
    trainingSet=data(1:55699,:);
    validationSet=data(55700:62661,:);
    trainTarget=trainingSet(:,1);
    trainMatrix=trainingSet(:,2:47);
    validationTarget=validationSet(:,1);
    validationMatrix=validationSet(:,2:47);

    clearvars trainingSet validationSet data;
    
    ErmsMat=zeros(ModelLim,1);
    N=length(trainMatrix);
    mu=zeros(1,46);
    for M=1:ModelLim
        DesignMat=ones(N,1);
        for i=1:M-1
            R=randperm(N);
            R=R(1:100);
            mu=mean(trainMatrix(R,:));
            Phi_j=zeros(N,1);
            for j=1:N
                X_minus_mu=trainMatrix(j,:)-mu;
                Phi_j(j)=exp((X_minus_mu*X_minus_mu')/(-2*S*S));
            end
            DesignMat=[ DesignMat Phi_j];
        end

        W=((pinv((DesignMat'*DesignMat)+Lambda*eye(M)))*DesignMat')*trainTarget;
        Err=(trainTarget-(DesignMat*W));
        E_D=((Err'*Err)/2);
        E_w = 0; 
        for k=1:length(W)
            E_w = E_w + ((W(k))^2) ; 
        end;
        E_w = E_w / 2;
        E = E_D + ( Lambda * E_w );
        ERMS=sqrt((2*E)/N);
        ErmsMat(M)=ERMS;
    end
    [ErmsMin,M_cfs]=min(ErmsMat);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Validate
    Lam=0.0001;
    ErmsLamMat=zeros(6,1);
    N=length(validationMatrix);
    for l=1:6
        Lam=Lam*10;
        DesignMat=ones(N,1);
        for i=1:M_cfs-1
            R=randperm(N);
            R=R(1:100);
            mu=mean(validationMatrix(R,:));
            Phi_j=zeros(N,1);
            for j=1:N
                X_minus_mu=validationMatrix(j,:)-mu;
                Phi_j(j)=exp((X_minus_mu*X_minus_mu')/(-2*S*S));
            end
            DesignMat=[ DesignMat Phi_j];
        end
        W=((pinv(DesignMat'*DesignMat)+Lam*eye(M_cfs,M_cfs))*DesignMat')*validationTarget;
        Err=(validationTarget-(DesignMat*W));
        E_D=((Err'*Err)/2);
        E_w = 0; 
        for k=1:length(W)
            E_w = E_w + ((W(k))^2) ; 
        end;
        E_w = E_w / 2;
        E = E_D + ( Lam * E_w );
        ERMS=sqrt((2*E)/N);
        ErmsLamMat(l)=ERMS;
    end
    [Min,Lam]=min(ErmsLamMat);
    Lam=(10^(Lam-2));
end