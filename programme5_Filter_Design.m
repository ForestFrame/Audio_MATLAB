clear;
clc;
format long;
close all;

% ==========原始信号========== %
[x1, fs1] = audioread('./Audio/实验五语音信号/小提琴.wav');

N1 = length(x1);  % 整个图由N1个样点构成
dt1 = 1 / fs1;
tscale1 = dt1 * N1;  % X轴显示的时间长度，单位为秒
t1 = 0 : dt1 : tscale1 - tscale1 / N1;

subplot(1, 2, 1);
plot(t1 .* 1000, x1);
title('小提琴信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y1 = fft(x1);
realy = 2 * abs(y1(1 : length(x1))) / length(x1);
realf = (0 : length(x1) - 1) * (fs1 / length(x1)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('小提琴信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========小提琴混杂噪声信号========== %
[x2, fs2] = audioread('./Audio/实验五语音信号/小提琴混杂声音_缩混.wav');

N2 = length(x2);  % 整个图由N2个样点构成
dt2 = 1 / fs2;
tscale2 = dt2 * N2;  % X轴显示的时间长度，单位为秒
t2 = 0 : dt2 : tscale2 - tscale2 / N2;

subplot(1, 2, 1);
plot(t2 .* 1000, x2);
title('小提琴混杂噪声信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y2 = fft(x2);
realy = 2 * abs(y2(1 : length(x2))) / length(x2);
realf = (0 : length(x2) - 1) * (fs2 / length(x2)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('小提琴混杂噪声信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========MATLAB工具箱生成的滤波器========== %
% =====IIR滤波器===== %
H1 = Filter_Design_code3;
x_filtered1 = filter(H1, x2);

subplot(1, 2, 1);
plot(t1 .* 1000, x_filtered1);
title('IIR滤波器去噪信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y_filtered1 = fft(x_filtered1);
realy = 2 * abs(y_filtered1(1 : length(x_filtered1))) / length(x_filtered1);
realf = (0 : length(x_filtered1) - 1) * (fs2 / length(x_filtered1)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('IIR滤波器去噪信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% =====FIR滤波器===== %
H2 = Filter_Design_code4;
x_filtered2 = filter(H2, x2);

subplot(1, 2, 1);
plot(t1 .* 1000, x_filtered2);
title('FIR滤波器去噪信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y_filtered2 = fft(x_filtered2);
realy = 2 * abs(y_filtered2(1 : length(x_filtered2))) / length(x_filtered2);
realf = (0 : length(x_filtered2) - 1) * (fs2 / length(x_filtered2)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('FIR滤波器去噪信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;