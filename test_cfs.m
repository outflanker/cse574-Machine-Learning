function [ErmsTest] = test_cfs(M,Lambda,S)
    load project1_data.mat;
    testingSet=data(62662:69623,:);
    testTarget=testingSet(:,1);
    testMatrix=testingSet(:,2:47);
    clearvars testingSet data;
    
    N=length(testMatrix);
    DesignMat=ones(N,1);
    for i=1:M-1
        R=randperm(N);
        R=R(1:100);
        mu=mean(testMatrix(R,:));
        Phi_j=zeros(N,1);
        for j=1:N
            X_minus_mu=testMatrix(j,:)-mu;
            Phi_j(j)=exp((X_minus_mu*X_minus_mu')/(-2*S*S));
        end
        DesignMat=[ DesignMat Phi_j];
    end
    
    W=((pinv((DesignMat'*DesignMat)+Lambda*eye(M)))*DesignMat')*testTarget;
    Err=(testTarget-(DesignMat*W));
    E_D=((Err'*Err)/2);
    E_w = 0; 
    for k=1:length(W)
        E_w = E_w + ((W(k))^2) ; 
    end;
    E_w = E_w / 2;
    E = E_D + ( Lambda * E_w );
    ErmsTest=sqrt((2*E)/N);
end
