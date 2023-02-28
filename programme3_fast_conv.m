clear;
clc;
format long;
close all;

% ==========ԭʼ�ź�========== %
[x, fs] = audioread('./Audio/ʵ���������ź�/С����.wav');
x = x(:, 1);
x = x';

N = length(x);  % ����ͼ��N1�����㹹��
dt = 1 / fs;
tscale = dt * N;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t = 0 : dt : tscale - tscale / N;

subplot(1, 2, 1);
% subplot(2, 4, 1);
plot(t .* 1000, x);
title('С�����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y = fft(x);
realy = 2 * abs(y(1 : length(x))) / length(x);
realf = (0 : length(x) - 1) * (fs / length(x)); 
subplot(1, 2, 2);
% subplot(2, 4, 5);
stem(realf, realy, '.');
title('С�����ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========С���ٻ��������ź�========== %
[Xn, fs1] = audioread('./Audio/ʵ���������ź�/С���ٻ�������_����.wav');
Xn = Xn(:, 1);
Xn = Xn';

N1 = length(Xn);  % ����ͼ��N1�����㹹��
dt1 = 1 / fs1;
tscale1 = dt1 * N1;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t1 = 0 : dt1 : tscale1 - tscale1 / N1;

subplot(1, 2, 1);
% subplot(2, 4, 2);
plot(t1 .* 1000, Xn);
title('С���ٻ��������ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y1 = fft(Xn);
realy = 2 * abs(Y1(1 : length(Xn))) / length(Xn);
realf = (0 : length(Xn) - 1) * (fs1 / length(Xn)); 
subplot(1, 2, 2);
% subplot(2, 4, 6);
stem(realf, realy, '.');
title('С���ٻ��������ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% ==========����˲�========== %
hn = load('hn.mat');  %���ļ�������ǰ��ͨ���˲������������ɵ��˲����еĵõ��ĵ�λȡ����Ӧ�Ĳ������ݵ�
for i = 1 : 122  %�ӱ������ݵ�Ԫ����������ȡ��λȡ����Ӧ�ķ�ֵ
    Hn(i) = hn.Position{i, 1}(1, 2);
end

L1 = pow2(nextpow2(length(Xn) + length(Hn) - 1));  %ȷ��FFT���پ���ĵ���
Xk = fft(Xn, L1);  %����Xn��L��FFT,���ΪXn
Hk = fft(Hn, L1);  %����Hn��L��FFT,���ΪHk
Yk = Xk .* Hk;  %����YK,Ƶ����˼�Ϊʱ�����
y1n = ifft(Yk, L1);  %��YK����IFFT�����y1(n)
y2n = conv(Xn, Hn);  %����y2(n)�ľ������Ϊ���Ծ��

figure;
% =====���پ��===== %
dt2 = 1 / fs1;
tscale2 = dt2 * L1;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t2 = 0 : dt2 : tscale2 - tscale2 / L1;
subplot(1, 2, 1);
% subplot(2, 4, 3);
plot(t2 .* 1000, y1n);
title('���پ���˲����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;
audiowrite('./Audio/ʵ���������ź�/���پ���˲����ź�.wav', y1n, 8000);

Y2 = fft(y1n);
realy = 2 * abs(Y2(1 : length(y1n))) / length(y1n);
realf = (0 : length(y1n) - 1) * (fs1 / length(y1n)); 
subplot(1, 2, 2);
% subplot(2, 4, 7);
stem(realf, realy, '.');
title('���پ���˲����ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% =====���Ծ��===== %
L2 = length(y2n);
dt3 = 1 / fs1;
tscale3 = dt3 * L2;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t3 = 0 : dt3 : tscale3 - tscale3 / L2;
subplot(1, 2, 1);
% subplot(2, 4, 4);
plot(t3 .* 1000, y2n);
title('���Ծ���˲����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;
audiowrite('./Audio/ʵ���������ź�/���Ծ���˲����ź�.wav', y2n, 8000);

Y3 = fft(y2n);
realy = 2 * abs(Y3(1 : length(y2n))) / length(y2n);
realf = (0 : length(y2n) - 1) * (fs1 / length(y2n)); 
subplot(1, 2, 2);
% subplot(2, 4, 8);
stem(realf, realy, '.');
title('���Ծ���˲����ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

