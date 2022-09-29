clear;
clc;
format long;

figure;
% ==========ԭʼ�ź�========== %
[x, fs] = audioread('./�人.wav');

N = 14000;  % ����ͼ��N�����㹹��
dt = 1 / fs;
tscale = dt * N;  % X����ʾ��ʱ�䳤�ȣ���λΪ��
t = 0 : dt : tscale - tscale / N;

% subplot(1, 2, 1);
% plot(t .* 1000, x);
title('ԭ�����ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y = fft(x);
realy = 2 * abs(y(1 : length(x))) / length(x);
realf = (0 : length(x) - 1) * (fs / length(x)); 
stem(realf, realy, '.');
title('ԭ�����ź�Ƶ��ͼ');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========���ٲ����ʺ���ź�========== %
% �˵������ź�Ƶ����0��600Hz֮�䣬��ԭ�ź�Ƶ�׿��Կ����ź�������100��500Hz֮�䣬�������ȡ������Ϊ2000HzΪ��������1000HzΪ�ٽ������800HzΪǷ������
% =====������===== %
x1 = decimate(x, 4);
t1 = decimate(t, 4);
fs1 = fs / 4;
subplot(3, 2, 1);
plot(t1 .* 1000, x1);
title('�����������ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y1 = fft(x1);
realy = 2 * abs(y1(1 : length(x1))) / length(x1);
realf = (0 : length(x1) - 1) * (fs1 / length(x1)); 
subplot(3, 2, 2);
stem(realf, realy, '.');
title('�����������ź�Ƶ��ͼ');
axis([0, 2000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====�ٽ����===== %
x2 = decimate(x, 8);
t2 = decimate(t, 8);
fs2 = fs / 8;
subplot(3, 2, 3);
plot(t2 .* 1000, x2);
title('�ٽ���������ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y2 = fft(x2);
realy = 2 * abs(y2(1 : length(x2))) / length(x2);
realf = (0 : length(x2) - 1) * (fs2 / length(x2)); 
subplot(3, 2, 4);
stem(realf, realy, '.');
title('�ٽ���������ź�Ƶ��ͼ');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====Ƿ����===== %
x3 = decimate(x, 10);
t3 = decimate(t, 10);
fs3 = fs / 10;
subplot(3, 2, 5);
plot(t3 .* 1000, x3);
title('Ƿ���������ź�ʱ��ͼ');
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

y3 = fft(x3);
realy = 2 * abs(y3(1 : length(x3))) / length(x3);
realf = (0 : length(x3) - 1) * (fs3 / length(x3)); 
subplot(3, 2, 6);
stem(realf, realy, '.');
title('Ƿ���������ź�Ƶ��ͼ');
axis([0, 800, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

figure;
% ==========���ٲ����ʺ���źŻָ�========== %
f = 8000;
f1 = 2000;
f2 = 1000;
f3 = 800;
tscale = 1;

% =====������===== %
n_point = 14000 / 4;  % ��������
ts = 1 / f1;  % ����ʱ����
to = linspace(0, tscale, n_point);
K = 4;  % ��ԭ����źŵ㱶��
dt = ts / K;  % ��ԭ��ĵ�ʱ����
ta = 0 : dt : n_point * ts;
y_recover1 = zeros(length(ta), 1);  % �ָ��ź�y���Ƚ���һ��0���󣬴�0��1��ʱ����Ϊdt

for t = 0 : length(ta) - 1  % ����������ÿ��ֵ
    for m = 0 : length(to) - 1  % �ۼ�sinc��ԭ������Ӧ��Ļ�
        y_recover1(t + 1) = y_recover1(t + 1) + x1(m + 1) * sinc((t * dt - m * ts) / ts);
    end
end

subplot(3, 2, 1);
plot(ta.* 1000, y_recover1);
title('�������ؽ��ź�(�ڲ巨)');
axis([-inf, +inf, -1, +1]);  % ����������ʾ��Χ��
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y1 = fft(y_recover1);
realy = 2 * abs(Y1(1 : length(y_recover1))) / length(y_recover1);
realf = (0 : length(y_recover1) - 1) * (fs / length(y_recover1)); 
subplot(3, 2, 2);
stem(realf, realy, '.');
title('�����������źŻָ���Ƶ��ͼ');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====�ٽ����===== %
n_point = 14000 / 8;  % ��������
ts = 1 / f2;  % ����ʱ����
to = linspace(0, tscale, n_point);
K = 8;  % ��ԭ����źŵ㱶��
dt = ts / K;  % ��ԭ��ĵ�ʱ����
ta = 0 : dt : n_point * ts;
y_recover2 = zeros(length(ta), 1);  % �ָ��ź�y���Ƚ���һ��0���󣬴�0��1��ʱ����Ϊdt

for t = 0 : length(ta) - 1  % ����������ÿ��ֵ
    for m = 0 : length(to) - 1  % �ۼ�sinc��ԭ������Ӧ��Ļ�
        y_recover2(t + 1) = y_recover2(t + 1) + x2(m + 1) * sinc((t * dt - m * ts) / ts);
    end
end

subplot(3, 2, 3);
plot(ta.* 1000, y_recover2);
title('�ٽ�����ؽ��ź�(�ڲ巨)');
axis([-inf, +inf, -1, +1]);  % ����������ʾ��Χ��
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y2 = fft(y_recover2);
realy = 2 * abs(Y2(1 : length(y_recover2))) / length(y_recover2);
realf = (0 : length(y_recover2) - 1) * (fs / length(y_recover2)); 
subplot(3, 2, 4);
stem(realf, realy, '.');
title('�ٽ���������źŻָ���Ƶ��ͼ');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

% =====Ƿ����===== %
n_point = 14000 / 10;  % ��������
ts = 1 / f3;  % ����ʱ����
to = linspace(0, tscale, n_point);
K = 10;  % ��ԭ����źŵ㱶��
dt = ts / K;  % ��ԭ��ĵ�ʱ����
ta = 0 : dt : n_point * ts;
y_recover3 = zeros(length(ta), 1);  % �ָ��ź�y���Ƚ���һ��0���󣬴�0��1��ʱ����Ϊdt

for t = 0 : length(ta) - 1  % ����������ÿ��ֵ
    for m = 0 : length(to) - 1  % �ۼ�sinc��ԭ������Ӧ��Ļ�
        y_recover3(t + 1) = y_recover3(t + 1) + x3(m + 1) * sinc((t * dt - m * ts) / ts);
    end
end

subplot(3, 2, 5);
plot(ta.* 1000, y_recover3);
title('Ƿ�����ؽ��ź�(�ڲ巨)');
axis([-inf, +inf, -1, +1]);  % ����������ʾ��Χ��
xlabel('t/ms', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;

Y2 = fft(y_recover2);
realy = 2 * abs(Y2(1 : length(y_recover2))) / length(y_recover2);
realf = (0 : length(y_recover2) - 1) * (fs / length(y_recover2)); 
subplot(3, 2, 6);
stem(realf, realy, '.');
title('�ٽ���������źŻָ���Ƶ��ͼ');
axis([0, 1000, 0, 0.04]);
xlabel('f/Hz', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
ylabel('��ѹ/V', 'FontName', '����', 'FontWeight', 'normal', 'FontSize', 14);
grid on;




