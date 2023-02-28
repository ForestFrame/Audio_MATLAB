clc;
format long;

% ==========原始信号========== %
[x1, fs1] = audioread('./Audio/实验二语音信号/小提琴.wav');

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
% ==========噪声信号========== %
[x3, fs3] = audioread('./Audio/实验二语音信号/噪声.wav');

N3 = length(x3);  % 整个图由N1个样点构成
dt3 = 1 / fs3;
tscale3 = dt3 * N3;  % X轴显示的时间长度，单位为秒
t3 = 0 : dt3 : tscale3 - tscale3 / N3;

subplot(1, 2, 1);
plot(t3 .* 1000, x3);
title('噪声信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y3 = fft(x3);
realy = 2 * abs(y3(1 : length(x3))) / length(x3);
realf = (0 : length(x3) - 1) * (fs3 / length(x3)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('噪声信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========小提琴混杂噪声信号========== %
[x2, fs2] = audioread('./Audio/实验二语音信号/小提琴混杂声音_缩混.wav');

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
H = Filter_Design_code2;
x_filtered = filter(H, x2);

subplot(1, 2, 1);
plot(t1 .* 1000, x_filtered);
title('小提琴去噪信号时域图');
xlabel('t/ms', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y_filtered = fft(x_filtered);
realy = 2 * abs(y_filtered(1 : length(x_filtered))) / length(x_filtered);
realf = (0 : length(x_filtered) - 1) * (fs2 / length(x_filtered)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('小提琴去噪信号频谱图');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('电压/V', 'FontName', '宋体', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

audiowrite('./Audio/实验二语音信号/小提琴去噪.wav', x_filtered, 8000);




