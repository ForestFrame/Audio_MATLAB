clear;
clc;
format long;

% ==========原始信号========== %
[x, fs] = audioread('./Audio/小提琴混杂声音_缩混.wav');

N = length(x);  % 整个图由N个样点构成
dt = 1 / fs;
tscale = dt * N;  % X轴显示的时间长度，单位为秒
t = 0 : dt : tscale - tscale / N;

subplot(1, 2, 1);
plot(t .* 1000, x);
title('小提琴信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y = fft(x);
realy = 2 * abs(y(1 : length(x))) / length(x);
realf = (0 : length(x) - 1) * (fs / length(x)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('小提琴信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% ==========利用差分方程进行滤波========== %



