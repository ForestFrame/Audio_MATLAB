clear;
clc;
format long;
close all;

% ==========原始信号========== %
[x, fs] = audioread('./Audio/实验三语音信号/小提琴.wav');
x = x(:, 1);
x = x';

N = length(x);  % 整个图由N1个样点构成
dt = 1 / fs;
tscale = dt * N;  % X轴显示的时间长度，单位为秒
t = 0 : dt : tscale - tscale / N;

subplot(1, 2, 1);
% subplot(2, 4, 1);
plot(t .* 1000, x);
title('小提琴信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y = fft(x);
realy = 2 * abs(y(1 : length(x))) / length(x);
realf = (0 : length(x) - 1) * (fs / length(x)); 
subplot(1, 2, 2);
% subplot(2, 4, 5);
stem(realf, realy, '.');
title('小提琴信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========小提琴混杂噪声信号========== %
[Xn, fs1] = audioread('./Audio/实验三语音信号/小提琴混杂声音_缩混.wav');
Xn = Xn(:, 1);
Xn = Xn';

N1 = length(Xn);  % 整个图由N1个样点构成
dt1 = 1 / fs1;
tscale1 = dt1 * N1;  % X轴显示的时间长度，单位为秒
t1 = 0 : dt1 : tscale1 - tscale1 / N1;

subplot(1, 2, 1);
% subplot(2, 4, 2);
plot(t1 .* 1000, Xn);
title('小提琴混杂噪声信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y1 = fft(Xn);
realy = 2 * abs(Y1(1 : length(Xn))) / length(Xn);
realf = (0 : length(Xn) - 1) * (fs1 / length(Xn)); 
subplot(1, 2, 2);
% subplot(2, 4, 6);
stem(realf, realy, '.');
title('小提琴混杂噪声信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% ==========卷积滤波========== %
hn = load('hn.mat');  %此文件数据是前面通过滤波器工具箱生成的滤波器中的得到的单位取样相应的部分数据点
for i = 1 : 122  %从保存数据的元胞数组中提取单位取样相应的幅值
    Hn(i) = hn.Position{i, 1}(1, 2);
end

L1 = pow2(nextpow2(length(Xn) + length(Hn) - 1));  %确定FFT快速卷积的点数
Xk = fft(Xn, L1);  %计算Xn的L点FFT,结果为Xn
Hk = fft(Hn, L1);  %计算Hn的L点FFT,结果为Hk
Yk = Xk .* Hk;  %计算YK,频域相乘即为时域相卷
y1n = ifft(Yk, L1);  %对YK调用IFFT，求得y1(n)
y2n = conv(Xn, Hn);  %计算y2(n)的卷积，此为线性卷积

figure;
% =====快速卷积===== %
dt2 = 1 / fs1;
tscale2 = dt2 * L1;  % X轴显示的时间长度，单位为秒
t2 = 0 : dt2 : tscale2 - tscale2 / L1;
subplot(1, 2, 1);
% subplot(2, 4, 3);
plot(t2 .* 1000, y1n);
title('快速卷积滤波后信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;
audiowrite('./Audio/实验三语音信号/快速卷积滤波后信号.wav', y1n, 8000);

Y2 = fft(y1n);
realy = 2 * abs(Y2(1 : length(y1n))) / length(y1n);
realf = (0 : length(y1n) - 1) * (fs1 / length(y1n)); 
subplot(1, 2, 2);
% subplot(2, 4, 7);
stem(realf, realy, '.');
title('快速卷积滤波后信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% =====线性卷积===== %
L2 = length(y2n);
dt3 = 1 / fs1;
tscale3 = dt3 * L2;  % X轴显示的时间长度，单位为秒
t3 = 0 : dt3 : tscale3 - tscale3 / L2;
subplot(1, 2, 1);
% subplot(2, 4, 4);
plot(t3 .* 1000, y2n);
title('线性卷积滤波后信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;
audiowrite('./Audio/实验三语音信号/线性卷积滤波后信号.wav', y2n, 8000);

Y3 = fft(y2n);
realy = 2 * abs(Y3(1 : length(y2n))) / length(y2n);
realf = (0 : length(y2n) - 1) * (fs1 / length(y2n)); 
subplot(1, 2, 2);
% subplot(2, 4, 8);
stem(realf, realy, '.');
title('线性卷积滤波后信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

