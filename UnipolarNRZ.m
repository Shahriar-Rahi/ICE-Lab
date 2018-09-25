clc;
clear;
%bits=[0 1 0 0 1 0 1 0];
bits = randi([0, 1], 1,10);

bitrate = 1000;
T = length(bits)/bitrate;
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));

for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+1)*n) = 1*3;
  else
    x(i*n+1:(i+1)*n) = 0*3;
  end
end

plot(t,x,'r-');
axis([0 length(bits)/bitrate -5 5]);
title('Unipolar NRZ line coding');


origin_bits = zeros(1, round(length(x) / n));

for i = 1:length(x) / n
    origin_bits(i) = x(i * n) / 3;
end

for i = 1:length(x) / n
    count = 0;
    for j = 1:n
        if(x(((i-1) * n) + j) == 3)
            count = count + 1;
        end
    end
    if(count < n)
        origin_bits(i) = 0;
    else 
        origin_bits(i) = 1;
    end
end

disp("Randomly generated bits: ");
disp(bits);
disp("Bits retained from signal x: ");
disp(origin_bits);


