clearvars;
clc;
%% 导入数据
throttle = [0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85] * 0.01; % 油门开度
torque = [0, 27.16, 43.41, 59.22, 76.01, 90.08, 103.00, 121.49, 137.68, 154.14, 174.92, 196.02, 209.70, 217.83, 234.96, 261.14, 271.89]; % 扭矩 (N*m)
force = [0, 18966, 32080, 44544, 57108, 68062, 77231, 91412, 103026, 115037, 131005, 145128, 154748, 160245, 172325, 191969, 199568] * 0.001 * 9.8066; % 拉力 (N)

%% 拟合曲线
% 使用拟合工具
torque_fit_model = fit(throttle', torque', 'poly1');
force_fit_model = fit(throttle', force', 'poly1');

% 绘制拟合曲线
figure;
subplot(2,1,1);
plot(torque_fit_model, throttle, torque);
xlabel('油门开度'); ylabel('扭矩 (N·m)');
title('扭矩 vs. 油门开度');
legend('Location', 'best'); 

subplot(2,1,2);
plot(force_fit_model, throttle, force);
xlabel('油门开度'); ylabel('拉力 (N)');
title('拉力 vs. 油门开度');
legend('Location', 'best');

%% 拟合效果验证。 R2衡量模型解释数据变化的能力，NMSE衡量均方误差
% 计算预测值（拟合结果）
force_pred = force_fit_model(throttle); % 用模型计算拟合的拉力
torque_pred = torque_fit_model(throttle); % 用模型计算拟合的扭矩

% 计算拟合误差
NMSE_force = goodnessOfFit(force_pred, force', 'NMSE');
NMSE_torque = goodnessOfFit(torque_pred, torque', 'NMSE');

% 计算真实数据均值
mean_torque = mean(torque);
mean_force = mean(force);

% 计算 R²
R2_torque = 1 - sum((torque - torque_pred').^2) / sum((torque - mean_torque).^2);
R2_force = 1 - sum((force - force_pred').^2) / sum((force - mean_force).^2);

% 显示结果
disp(force_fit_model); 
disp(['Force NMSE = ', num2str(NMSE_force)]);
disp(['Force R² = ', num2str(R2_force)]);

disp(torque_fit_model);
disp(['Torque NMSE = ', num2str(NMSE_torque)]);
disp(['Torque R² = ', num2str(R2_torque)]);

% % 指定保存路径
% save_path = 'D:\Obsidian\2025毕业设计\pictures\fit_results.png'; 
% 
% % 保存图片
% saveas(gcf, save_path); % 使用 saveas 保存
