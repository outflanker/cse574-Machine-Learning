##############################################################################################################
##This is a Machine Learning Linear Regression Project by
## Siddharth Krishna Sinha
##############################################################################################################

This contains:

project1.m	  : This is the wrapper script that calls the training and testing scripts for both methods.
	            This also prints the computed parameters and model complexity.

train_cfs.m	  : Input(s)=ComplexityLimit, Initial Lambda value, Initial variance value
		    Output(s)=Complexity(Model), RMS value, Computed lambda value	
                    This function trains the data using closed form solution approach and validates it.

test_cfs.m	  : Input(s)=Complexity, Obtained Lambda value, Variance value
		    Output(s)=RMS value for test matrix
		    This function tests the model over the test set.

train_gd.m	  : Input(s)=ComplexityLimit, Initial Lambda value, Initial variance value
		    Output(s)=Complexity(Model), RMS value, Computed lambda value
		    This function trains the data using stochastic gradient descent approach and validates it.

test_gd.m	  : Input(s)=Complexity, Obtained Lambda value, Variance value
		    Output(s)=RMS value for test matrix
		    This function tests the model over the test set using gradient descent approach.	

Project report. 

readme.txt

####################################################################################################################	