function junk = run_nn()

    clear all 
    close all
    clc
    
    % Train the neural net
    run('init_nn.m')
    iterations = 10;
    
    % Test neural net
    for i = 1:iterations
       run('train_nn.m')
    end

    % Test neural net
    %run('test_nn.m')
end