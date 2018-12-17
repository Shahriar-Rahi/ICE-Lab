clc;
clear;
sig = [0 1 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0];



sampling_rate = 100;

maxV = 3;
prev = -maxV;
b8zs1 = [0 0 0 maxV -maxV -maxV maxV];
b8zs2 = [0 0 0 -maxV maxV maxV -maxV];

ami = zeros(1, length(sig) * sampling_rate); 
for i = 1 : length(sig)
    curr = 0;
    if sig(i) == 1  
        curr = -prev;
        prev =  -prev;
    end
    ami((i - 1) * sampling_rate + 1 : i * sampling_rate) = curr;
end


X = 1:length(ami);
subplot(3, 1, 1)
plot(X, ami)
grid on
ylim([-4 4])
title("AMI");

%decode ami
ami_decoded = zeros(1, length(ami) / sampling_rate);
for i = 1 : length(ami_decoded)
    count = 0;
    for j = 1 : sampling_rate
        if abs(ami(((i-1) * sampling_rate) + j)) == maxV
            count = count + 1;
        end
    end
    if count > sampling_rate / 2
        ami_decoded(i) = 1;
    end
%    ami_decoded(i) = ami(((i - 1) * sampling_rate) + 1);
end
disp(ami_decoded);

b8zs = zeros(1, length(ami_decoded) * sampling_rate);
hdb3 = zeros(1, length(ami_decoded) * sampling_rate);

prev = -maxV;
for i = 1 : length(ami_decoded)
    curr = 0;
    if sig(i) == 1
        count = 0;
        curr = -prev;
        prev = -prev;
    else
        count = count + 1;
        curr = 0;
        if(count == 8)
            b8zs((i - 8) * sampling_rate + 1 : (i - 7) * sampling_rate) = 0;
            b8zs((i - 7) * sampling_rate + 1 : (i - 6) * sampling_rate) = 0;
            b8zs((i - 6) * sampling_rate + 1 : (i - 5) * sampling_rate) = 0;
            b8zs((i - 5) * sampling_rate + 1 : (i - 4) * sampling_rate) = prev;
            b8zs((i - 4) * sampling_rate + 1 : (i - 3) * sampling_rate) = -prev;
            b8zs((i - 3) * sampling_rate + 1 : (i - 2) * sampling_rate) = 0;
            b8zs((i - 2) * sampling_rate + 1 : (i - 1) * sampling_rate) = -prev;
            curr = prev;
            count = 0;
        end
    end
    %b8zs(i) = curr;
    b8zs((i - 1) * sampling_rate + 1 : i * sampling_rate) = curr;
end

  
X = 1:length(b8zs);
subplot(3, 1, 2)
plot(X, b8zs)
grid on
ylim([-4 4])
title("b8zs");

count1 = 0;
prev = -maxV;
for i = 1 : length(ami_decoded)
    if sig(i) == 1
        count1 = count1 + 1;
        count = 0;
        hdb3((i - 1) * sampling_rate + 1 : i * sampling_rate) = -prev;
        prev = -prev;
    else
        count = count + 1;
        curr = 0;
        if(count == 4)
            if mod(count1, 2) == 0
                hdb3((i - 4) * sampling_rate + 1 : (i - 3) * sampling_rate) = -prev;
                prev = - prev;
            else
                count1 = count1 + 1;
            end
            hdb3((i - 1) * sampling_rate + 1 : i * sampling_rate) = prev; 
            count = 0;
        end
    end
end

X = 1:length(hdb3);
subplot(3, 1, 3)
plot(X, hdb3)
grid on
ylim([-4 4])
title("hdb3");

%decode both 
%cause fml

b8zsDec = zeros(1, length(b8zs) / sampling_rate);
hdb3Dec = zeros(1, length(hdb3) / sampling_rate);
prev = -maxV;
for i = 1 : length(b8zsDec)
       count = 0;
    countV = 0;
    for j = 1 : sampling_rate
        if ami(((i-1) * sampling_rate) + j) == -prev
            count = count + 1;
        elseif ami(((i-1) * sampling_rate) + j) == prev
            countV = countV + 1;
        end
    end
    if count > sampling_rate / 2
        b8zsDec(i) = 1;
        prev = -prev;
    elseif countV > sampling_rate / 2
        b8zsDec(i-3 : i+3) = 0;
    end
end

disp("b8zsDec:")
disp(b8zsDec);

prev = -maxV;
numberOf1s = 0;
for i = 1 : length(hdb3Dec)
    count = 0;
    countV = 0;
    for j = 1 : sampling_rate
        if ami(((i-1) * sampling_rate) + j) == -prev
            count = count + 1;
        elseif ami(((i-1) * sampling_rate) + j) == prev
            countV = countV + 1;
        end
    end
    if count > sampling_rate / 2
        hdb3Dec(i) = 1;
        prev = -prev;
    elseif countV > sampling_rate / 2
        hdb3Dec(i-3 : i) = 0;
    end
end

disp("hdb3Dec:")
disp(hdb3Dec);