S=0.7;
ModelLim=22;
Lambda=100;

[M_cfs,rms_cfs,lambda_cfs]= train_cfs(ModelLim,Lambda,S);
[ErmsTest_cfs]=test_cfs(M_cfs,lambda_cfs,S);

[M_gd,rms_gd,lambda_gd]= train_gd(ModelLim,Lambda,S);
[ErmsTest_gd]=test_gd(M_gd,lambda_gd,S);

fprintf('The model complexity M_cfs is %d\n', M_cfs);
fprintf('The model complexity M_gd is %d\n', M_gd);
fprintf('The regularization parameters lambda_cfs is %4.2f\n', lambda_cfs);
fprintf('The regularization parameters lambda_gd is %4.2f\n', lambda_gd);
fprintf('The root mean square error for The closed form solution is %4.2f\n', rms_cfs);
fprintf('The root mean square error for The gradient descent method is %4.2f\n', rms_gd);