clear;
clc;
format long;

figure;
% ==========原始信号========== %
[x, fs] = audioread('./武汉.wav');

N = 14000;  % 整个图由N个样点构成
dt = 1 / fs;
tscale = dt * N;  % X轴显示的时间长度，单位为秒
t = 0 : dt : tscale - tscale / N;

% subplot(1, 2, 1);
% plot(t .* 1000, x);
title('原语音信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y = fft(x);
realy = 2 * abs(y(1 : length(x))) / length(x);
realf = (0 : length(x) - 1) * (fs / length(x)); 
stem(realf, realy, '.');
title('原语音信号频谱图');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========减少采样率后的信号========== %
% 人的语音信号频率在0到600Hz之间，从原信号频谱可以看出信号能量在100到500Hz之间，因此以下取采样率为2000Hz为过采样，1000Hz为临界采样，800Hz为欠采样。
% =====过采样===== %
x1 = decimate(x, 4);
t1 = decimate(t, 4);
fs1 = fs / 4;
subplot(3, 2, 1);
plot(t1 .* 1000, x1);
title('过采样语音信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y1 = fft(x1);
realy = 2 * abs(y1(1 : length(x1))) / length(x1);
realf = (0 : length(x1) - 1) * (fs1 / length(x1)); 
subplot(3, 2, 2);
stem(realf, realy, '.');
title('过采样语音信号频谱图');
axis([0, 2000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====临界采样===== %
x2 = decimate(x, 8);
t2 = decimate(t, 8);
fs2 = fs / 8;
subplot(3, 2, 3);
plot(t2 .* 1000, x2);
title('临界采样语音信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y2 = fft(x2);
realy = 2 * abs(y2(1 : length(x2))) / length(x2);
realf = (0 : length(x2) - 1) * (fs2 / length(x2)); 
subplot(3, 2, 4);
stem(realf, realy, '.');
title('临界采样语音信号频谱图');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====欠采样===== %
x3 = decimate(x, 10);
t3 = decimate(t, 10);
fs3 = fs / 10;
subplot(3, 2, 5);
plot(t3 .* 1000, x3);
title('欠采样语音信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y3 = fft(x3);
realy = 2 * abs(y3(1 : length(x3))) / length(x3);
realf = (0 : length(x3) - 1) * (fs3 / length(x3)); 
subplot(3, 2, 6);
stem(realf, realy, '.');
title('欠采样语音信号频谱图');
axis([0, 800, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========减少采样率后的信号恢复========== %
f = 8000;
f1 = 2000;
f2 = 1000;
f3 = 800;
tscale = 1;

% =====过采样===== %
n_point = 14000 / 4;  % 采样点数
ts = 1 / f1;  % 采样时间间隔
to = linspace(0, tscale, n_point);
K = 4;  % 还原后的信号点倍数
dt = ts / K;  % 还原后的点时间间隔
ta = 0 : dt : n_point * ts;
y_recover1 = zeros(length(ta), 1);  % 恢复信号y，先建立一个0矩阵，从0到1，时间间隔为dt

for t = 0 : length(ta) - 1  % 求过采样后的每个值
    for m = 0 : length(to) - 1  % 累加sinc与原函数对应点的积
        y_recover1(t + 1) = y_recover1(t + 1) + x1(m + 1) * sinc((t * dt - m * ts) / ts);
    end
end

subplot(3, 2, 1);
plot(ta.* 1000, y_recover1);
title('过采样重建信号(内插法)');
axis([-inf, +inf, -1, +1]);  % 调节坐标显示范围。
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y1 = fft(y_recover1);
realy = 2 * abs(Y1(1 : length(y_recover1))) / length(y_recover1);
realf = (0 : length(y_recover1) - 1) * (fs / length(y_recover1)); 
subplot(3, 2, 2);
stem(realf, realy, '.');
title('过采样语音信号恢复后频谱图');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====临界采样===== %
n_point = 14000 / 8;  % 采样点数
ts = 1 / f2;  % 采样时间间隔
to = linspace(0, tscale, n_point);
K = 8;  % 还原后的信号点倍数
dt = ts / K;  % 还原后的点时间间隔
ta = 0 : dt : n_point * ts;
y_recover2 = zeros(length(ta), 1);  % 恢复信号y，先建立一个0矩阵，从0到1，时间间隔为dt

for t = 0 : length(ta) - 1  % 求过采样后的每个值
    for m = 0 : length(to) - 1  % 累加sinc与原函数对应点的积
        y_recover2(t + 1) = y_recover2(t + 1) + x2(m + 1) * sinc((t * dt - m * ts) / ts);
    end
end

subplot(3, 2, 3);
plot(ta.* 1000, y_recover2);
title('临界采样重建信号(内插法)');
axis([-inf, +inf, -1, +1]);  % 调节坐标显示范围。
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y2 = fft(y_recover2);
realy = 2 * abs(Y2(1 : length(y_recover2))) / length(y_recover2);
realf = (0 : length(y_recover2) - 1) * (fs / length(y_recover2)); 
subplot(3, 2, 4);
stem(realf, realy, '.');
title('临界采样语音信号恢复后频谱图');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====欠采样===== %
n_point = 14000 / 10;  % 采样点数
ts = 1 / f3;  % 采样时间间隔
to = linspace(0, tscale, n_point);
K = 10;  % 还原后的信号点倍数
dt = ts / K;  % 还原后的点时间间隔
ta = 0 : dt : n_point * ts;
y_recover3 = zeros(length(ta), 1);  % 恢复信号y，先建立一个0矩阵，从0到1，时间间隔为dt

for t = 0 : length(ta) - 1  % 求过采样后的每个值
    for m = 0 : length(to) - 1  % 累加sinc与原函数对应点的积
        y_recover3(t + 1) = y_recover3(t + 1) + x3(m + 1) * sinc((t * dt - m * ts) / ts);
    end
end

subplot(3, 2, 5);
plot(ta.* 1000, y_recover3);
title('欠采样重建信号(内插法)');
axis([-inf, +inf, -1, +1]);  % 调节坐标显示范围。
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y2 = fft(y_recover2);
realy = 2 * abs(Y2(1 : length(y_recover2))) / length(y_recover2);
realf = (0 : length(y_recover2) - 1) * (fs / length(y_recover2)); 
subplot(3, 2, 6);
stem(realf, realy, '.');
title('临界采样语音信号恢复后频谱图');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;




