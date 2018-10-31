n=[1 0 0 1 0 0 0 1]; %145D
for i=1:length(n)
    if n(i) == 1
        n(i)=3;
    else
        n(i)=0;
    end
end

in=1;

br = 1;
bs = 200;
T = length(n)/br;
%disp(T);
N = bs*length(n);
%disp(N);
dt = T/N;
%disp(dt);
t = 0:dt:T;
%t=0:.0001:length(n);
% disp(length(t));
yy = zeros(1, length(t));
% disp(length(yy));
for j=1:length(t)
    if t(j)<=in
        yy(j)=n(in);
    else
        yy(j)=n(in); 
    in=in+1;
    end
end
%title('Unipolar NRZ');
plot(t,yy,'g-');
title('Unipolar NRZ');
axis([0 length(n) -5 5]);


origin = zeros(1, length(n));
 for i = 1:length(n) / br
     count = 0;
     for j = 1:br
         if(yy(((i-1) * br) + j) == 3)
             count = count + 1;
        end
    end
    if(count < br / 2)
         origin(i) = 0;
     else 
         origin(i) = 1;
     end
 end
 
 disp(origin);
    