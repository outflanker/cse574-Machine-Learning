function [Erms_test_gd] = test_gd(M,Lambda,S)
    load project1_data.mat;
    testSet=data(1:55699,:);
    testTarget=testSet(:,1);
    testMatrix=testSet(:,2:47);
    
    clearvars testSet data;
    
    Features=46;
    N=length(testMatrix);
    DesignMat=ones(N,1);
    for i=1:Features-1
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
    W=zeros(M,1);
    ERMS=10;
    n=1;
    change=1000;
    for j=1:N
        change_new=(testTarget(j)-(DesignMat(j,1:M)*W))*DesignMat(j,1:M)';
        if(change_new>change)
            n=0.5;
        end
        if(abs(change_new-change)<0.0005)
            break;
        end
        change=change_new;
        tmp=n*change;
        W=W+tmp;
    end

    Err=(testTarget-(DesignMat(:,1:M)*W));
    E_D=((Err'*Err)/2);
    E_w = 0; 
    for k=1:length(W)
        E_w = E_w + ((W(k))^2) ; 
    end;
    E_w = E_w / 2;
    E = E_D + ( Lambda * E_w );
    ERMS=sqrt((2*E)/N);   
    Erms_test_gd=ERMS;
end