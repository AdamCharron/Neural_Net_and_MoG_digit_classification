Neural Net and Mixture of Gaussian learning model experimentation.
Used a dataset of drawings of 2 and 3 digits to experiment with the above 2 models, and gain familiarity with some paramteres, as well as 
fine-tuning them, for better prediction abilities.

Under NN, can find code for initializing, training, and testing a neural net on the two datasets.
run_nn.m is the main function, which runs all three in order, and plots their classificaiton error rates as the model develops. 

Under MoG, can find the code for the mixture of Gaussian models. 
mog_run.m is the main function, comparing results across various parameter values. Plots these trends, and plots an average MoG representation of '2' and '3' digits