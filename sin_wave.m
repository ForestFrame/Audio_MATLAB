N = 63;
tscale = 1;
dt = tscale / N;  % 每个样点间的时间间隔
t = 0 : dt : tscale;
f1 = 1;
y1 = sin(2 * pi * f1 * t);  % 0.5为振幅。
plot(t, y1);

format short
y = round(y1 * 10000) / 10000;
dlmwrite('sin.txt', y);