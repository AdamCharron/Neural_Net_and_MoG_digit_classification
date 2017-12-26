clear all
load digits;

x = [train2, train3];
y = [valid2, valid3];
z = [test2, test3];

errorTrain = zeros(1, 4);
errorValidation = zeros(1, 4);
errorTest = zeros(1, 4);
numComponent = [2, 5, 15, 25];
targetsT = zeros(1,length(x(1,:)));
targetsV = zeros(1,length(y(1,:)));
targetsS = zeros(1,length(z(1,:)));

logProbXtrain = zeros(4,600);
logProbYtrain = zeros(4,600);

logProbXvalid = zeros(4,200);
logProbYvalid = zeros(4,200);

logProbXtest = zeros(4,400);
logProbYtest = zeros(4,400);

for i = 1 : 4
    K = numComponent(i);
% Train a MoG model with K components for digit 2
    [p2,mu2,vary2,temp] = mogEM(x(:,1:300),K,20,0.01,0);
    
% Train a MoG model with K components for digit 3
    [p3,mu3,vary3,temp] = mogEM(x(:,301:600),K,20,0.01,0);

% Caculate the probability P(d=1|x) and P(d=2|x), 
% classify examples, and compute the error rate
    logProbXtrain(i,:) = mogLogProb(p2,mu2,vary2,x);
    logProbYtrain(i,:) = mogLogProb(p3,mu3,vary3,x);
    
    logProbXvalid(i,:) = mogLogProb(p2,mu2,vary2,y);
    logProbYvalid(i,:) = mogLogProb(p3,mu3,vary3,y);
    
    logProbXtest(i,:) = mogLogProb(p2,mu2,vary2,z);
    logProbYtest(i,:) = mogLogProb(p3,mu3,vary3,z);
    
end

% Plot the error rate
for j = 1:4
    for i = 1:length(x(1,:))
       if logProbXtrain(j,i) > logProbYtrain(j,i)
           if i <= 300
               targetsT(i) = 1;
           else
               targetsT(i) = 0;
           end
       else
           if i > 300
               targetsT(i) = 1;
           else
               targetsT(i) = 0;
           end
       end
    end
    for i = 1:length(y(1,:))
       if logProbXvalid(j,i) > logProbYvalid(j,i)
           if i <= 100
               targetsV(i) = 1;
           else
               targetsV(i) = 0;
           end
       else
           if i > 100
               targetsV(i) = 1;
           else
               targetsV(i) = 0;
           end
       end
    end
    for i = 1:length(z(1,:))
       if logProbXtest(j,i) > logProbYtest(j,i)
           if i <= 200
               targetsS(i) = 1;
           else
               targetsS(i) = 0;
           end
       else
           if i > 200
               targetsS(i) = 1;
           else
               targetsS(i) = 0;
           end
       end
    end
    errorTrain(j) = (1-mean(targetsT'))*100;
    errorValid(j) = (1-mean(targetsV'))*100;
    errorTest(j) = (1-mean(targetsS'))*100;
end

errorTrain
errorValid
errorTest

plot([2,5,15,25],errorTrain, 'g')
hold on
plot([2,5,15,25],errorValid, 'b')
hold on
plot([2,5,15,25],errorTest, 'r')
title('Error rates of MoG using 2,5,15,and 25 components')
xlabel('Components')
ylabel('Error rates')
legend('train','valid','test')
hold off

% Plot 2 and 3 digit output from the (last) 25-component MoG
mu_array = zeros(size(mu2,1), size(mu2,2), 2);
mu_array(:,:,1) = mu2;
mu_array(:,:,2) = mu3;
vary_array = zeros(size(vary2,1), size(vary2,2), 2);
vary_array(:,:,1) = vary2;
vary_array(:,:,2) = vary3;
visualize_digits(mu_array,vary_array)