clc;
clear;
bits = [0 1 0 0 1 0 1 0];
%bits = randi([0, 1], 1,10);
%bitrate = 1000;
T=length(bits);
%T = length(bits)/bitrate;
n=300;
N=n*T;
%N = n*length(bits);
dt=T/N;
t=0:dt:T;
x=zeros(1,length(t));

prev = 3;

for i=0:T-1
    if bits(i+1)==1
        prev = -prev;
        x(i*n+1 : (i+1)*n)=prev;
    else
        %prev = 0;
        x(i*n+1 : (i+1)*n)=prev;
    end
end
plot(t,x,'black-');
%plot(t,x);
axis([0 t(end) -5 5]);
grid on
%grid on;
title('NRZ-I');


origin_bits = zeros(1, round(length(x) / n));

for i = 1:length(x) / n
    origin_bits(i) = x(i * n) / 3;
end
temp_bits = origin_bits;
%for i = 1:length(x) / n
    %count = 0;
    %for j = 1:n
        %if(x(((i-1) * n) + j) == 3)
            %count = count + 1;
        %end
    %end
    %if(count < n)
        %origin_bits(i) = 0;
    %else 
        %origin_bits(i) = 1;
    %end
%end

flag = 1;
for i = 1:length(origin_bits)
    if(origin_bits(i) == flag)
        origin_bits(i) = 0;
    else
        flag = -flag;
        origin_bits(i) = 1;
    end
end

disp("Randomly generated bits: ");
disp(bits);
%disp("temp bits to check");
%disp(temp_bits);
disp("Bits retained from signal x: ");
disp(origin_bits);