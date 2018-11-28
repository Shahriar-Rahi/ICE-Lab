clc;
clear;
bits = [1 1 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 1 0];
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
zeros = 0;
zecnt = 0;
ifageche = 0;
for i=0:T-1
    if(zeros == 8)
        zecnt = 1;
    end
    if(ifageche == 1)
        i = i + 8;
        ifageche = 0;
    end
    if (bits(i+1)==1)
        %prev = -prev;
        x(i*n+1 : (i+1)*n)=prev;
        prev = -prev;
        zeros = 0;
    else
        %prev = 0;
        %prev = -prev;
        if(((T-1) - i >= 8) && bits(i+1) == 0 && bits(i+2) == 0 && bits(i+3) == 0 && bits(i+4) == 0 && bits(i+5) == 0 && bits(i+6) == 0 && bits(i+7) == 0 && bits(i+8) == 0)
            x(i*(n+1) : (i+1)*n)=0;
            x((i+2)*n+1 : (i+3)*n)=0;
            x((i+3)*n+1 : (i+4)*n)=0;
            prev = -prev;
            x((i+4)*n+1 : (i+5)*n)=prev;
            prev = -prev;
            x((i+5)*n+1 : (i+6)*n)=prev;
            prev = -prev;
            x((i+6)*n+1 : (i+7)*n)=0;
            x((i+7)*n+1 : (i+8)*n)=prev;
            %prev = -prev;
            x((i+8)*n+1 : (i+9)*n)=prev;
            %prev = -prev;
            ifageche = 1;
        %else
            %x(i*n+1 : (i+1)*n)=0;
        end
        zeros = zeros + 1;
    end
end
plot(t,x,'black-');
%plot(t,x);
axis([0 t(end) -5 5]);
grid on
%grid on;
title('B8ZS');


origin_bits = zeros(1, round(length(x) / n));

for i = 1:length(x) / n
    origin_bits(i) = x(i * n) / 3;
end
%temp_bits = origin_bits;
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
    if(origin_bits(i) == 1 || origin_bits(i) == -1)
        origin_bits(i) = 1;
    else
        %flag = -flag;
        origin_bits(i) = 0;
    end
end

disp("Randomly generated bits: ");
disp(bits);
%disp("temp bits to check");
%disp(temp_bits);
disp("Bits retained from signal x: ");
disp(origin_bits);