clear;
clc;
format long;

% ==========ԭʼ�ź�========== %
[x, fs] = audioread('./Audio/С���ٻ�������_����.wav');

N = length(x);  % ����ͼ��N�����㹹��
dt = 1 / fs;
tscale = dt * N;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t = 0 : dt : tscale - tscale / N;

subplot(1, 2, 1);
plot(t .* 1000, x);
title('С�����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y = fft(x);
realy = 2 * abs(y(1 : length(x))) / length(x);
realf = (0 : length(x) - 1) * (fs / length(x)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('С�����ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% ==========���ò�ַ��̽����˲�========== %



