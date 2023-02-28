clc;
format long;

% ==========ԭʼ�ź�========== %
[x1, fs1] = audioread('./Audio/ʵ��������ź�/С����.wav');

N1 = length(x1);  % ����ͼ��N1�����㹹��
dt1 = 1 / fs1;
tscale1 = dt1 * N1;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t1 = 0 : dt1 : tscale1 - tscale1 / N1;

subplot(1, 2, 1);
plot(t1 .* 1000, x1);
title('С�����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y1 = fft(x1);
realy = 2 * abs(y1(1 : length(x1))) / length(x1);
realf = (0 : length(x1) - 1) * (fs1 / length(x1)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('С�����ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========�����ź�========== %
[x3, fs3] = audioread('./Audio/ʵ��������ź�/����.wav');

N3 = length(x3);  % ����ͼ��N1�����㹹��
dt3 = 1 / fs3;
tscale3 = dt3 * N3;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t3 = 0 : dt3 : tscale3 - tscale3 / N3;

subplot(1, 2, 1);
plot(t3 .* 1000, x3);
title('�����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y3 = fft(x3);
realy = 2 * abs(y3(1 : length(x3))) / length(x3);
realf = (0 : length(x3) - 1) * (fs3 / length(x3)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('�����ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========С���ٻ��������ź�========== %
[x2, fs2] = audioread('./Audio/ʵ��������ź�/С���ٻ�������_����.wav');

N2 = length(x2);  % ����ͼ��N2�����㹹��
dt2 = 1 / fs2;
tscale2 = dt2 * N2;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t2 = 0 : dt2 : tscale2 - tscale2 / N2;

subplot(1, 2, 1);
plot(t2 .* 1000, x2);
title('С���ٻ��������ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y2 = fft(x2);
realy = 2 * abs(y2(1 : length(x2))) / length(x2);
realf = (0 : length(x2) - 1) * (fs2 / length(x2)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('С���ٻ��������ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========MATLAB���������ɵ��˲���========== %
H = Filter_Design_code2;
x_filtered = filter(H, x2);

subplot(1, 2, 1);
plot(t1 .* 1000, x_filtered);
title('С����ȥ���ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y_filtered = fft(x_filtered);
realy = 2 * abs(y_filtered(1 : length(x_filtered))) / length(x_filtered);
realf = (0 : length(x_filtered) - 1) * (fs2 / length(x_filtered)); 
subplot(1, 2, 2);
stem(realf, realy, '.');
title('С����ȥ���ź�Ƶ��ͼ');
axis([0, 4000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

audiowrite('./Audio/ʵ��������ź�/С����ȥ��.wav', x_filtered, 8000);




