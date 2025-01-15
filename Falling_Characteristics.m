%% Falling Characteristics
% Author: Lauryn Peters
% Date: January 28, 2014

% Purpose: To determine and visualize trends in differnt variables between men and women
% during a fall using linear regression. 

clear all; close all; clc; 

%% Load Dataset

balance_data = readtable("BalanceData.xlsx"); % load balance dataset
balance_data = balance_data(1:40, :); % truncate non-meaningful data 

g = 9.81; % define gravity constant

% calculate initial engery of each subject and append the data as a column in the dataset
balance_data.Einitial = balance_data.weight_kg_.*g.*balance_data.heightOfGT_m_; 

% create subsets for each gender
men = balance_data(balance_data.Gender == "M", :);
women = balance_data(balance_data.Gender == "F", :);

%% Plot Fall Characteristics for Energy

 % create linear regression model for the women subset where the
 % GT ImpactVelocity Normalized By GT Height is the repsonse variable and 
 % the initial energy is the predictor variable 
mdl_w = fitlm(women,'GTImpactVelocityNormalizedByGTHeight_m_s_~Einitial');
coefsw = mdl_w.Coefficients.Estimate; % 2x1 [intercept; slope]

% plot balance data for women 
figure;
plot(women.Einitial, women.GTImpactVelocityNormalizedByGTHeight_m_s_, 'g.', 'MarkerSize', 12)
xlabel('Initial Energy (J)')
ylabel('GT Impact Velocity (m/s)')
title('Fall Characteristics')
hold on

% Plot linear fit for women subset
ref1 = refline(coefsw(2),coefsw(1));
ref1.Color = 'g';
hold on

 % create linear regression model for the men subset where the
 % GT ImpactVelocity Normalized By GT Height is the repsonse variable and 
 % the initial energy is the predictor variable 
mdl_m = fitlm(men,'GTImpactVelocityNormalizedByGTHeight_m_s_~Einitial');
coefsm = mdl_m.Coefficients.Estimate; % 2x1 [intercept; slope]

% plot balance data for men 
plot(men.Einitial, men.GTImpactVelocityNormalizedByGTHeight_m_s_, 'b.', 'MarkerSize', 12)
hold on

% Plot linear fit for men subset
ref2 = refline(coefsm(2),coefsm(1));
ref2.Color = 'b';

% display R squared value on plot
txt = ['W R^2: ', num2str(mdl_w.Rsquared.Ordinary)];
text(810,3.4, txt, 'FontSize', 10, 'Color', 'g')

txt2 = ['M R^2: ', num2str(mdl_m.Rsquared.Ordinary)];
text(600,2.9, txt2, 'FontSize', 10, 'Color', 'b')

legend('Women', 'Linear Fit for Women', 'Men', 'Linear Fit for Men', 'Location', 'southeast')

%% Plot Fall Characteristics for Reaction Time

 % create linear regression model for the women subset where the
 % GT Impact Velocity is the repsonse variable and 
 % reaction time is the predictor variable 
mdl_w2 = fitlm(women,'GTImpactVelocity_m_s_~reactionTime_s_');
coefs_w2 = mdl_w2.Coefficients.Estimate; % 2x1 [intercept; slope]

% plot balance data for women
figure;
plot(women.reactionTime_s_, women.GTImpactVelocity_m_s_, 'g.', 'MarkerSize', 12)
xlabel('Reaction Time (s)')
ylabel('Impact Velocity of GT (m/s)')
title('Fall Characteristics')
hold on

% Plot linear fit for women subset
ref_w1 = refline(coefs_w2(2),coefs_w2(1));
ref_w1.Color = 'g';
hold on

 % create linear regression model for the men subset where the
 % GT Impact Velocity is the repsonse variable and 
 % reaction time is the predictor variable 
mdl_m2 = fitlm(men,'GTImpactVelocity_m_s_~reactionTime_s_');
coefs_m2 = mdl_m2.Coefficients.Estimate; % 2x1 [intercept; slope]

% plot balance data for women
plot(men.reactionTime_s_, men.GTImpactVelocity_m_s_, 'b.', 'MarkerSize', 12)
hold on

% Plot linear fit for men subset
ref_m2 = refline(coefs_m2(2),coefs_m2(1));
ref_m2.Color = 'b';

% display R squared value on plot
txt = ['W R^2: ', num2str(mdl_w2.Rsquared.Ordinary)];
text(0.285,3.4, txt, 'FontSize', 10, 'Color', 'g')

txt2 = ['M R^2: ', num2str(mdl_m2.Rsquared.Ordinary)];
text(0.29,2.75, txt2, 'FontSize', 10, 'Color', 'b')

legend('Women', 'Linear Fit for Women', 'Men', 'Linear Fit for Men', 'Location', 'southeast')
