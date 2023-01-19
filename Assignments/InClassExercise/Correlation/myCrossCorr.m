function [rxy,lagindex] = myCrossCorr(xx,yy)

lx = length(xx); 
ly = length(yy);
if lx >= ly % always keep x1 as the longer sequence 
    x1 = xx;
    y1 = yy;
else
    x1 = yy;
    y1 = xx;
end

lag = 2*lx - 1;
lagindex = 1:lag;
y1 = [zeros(lx,1);y1; zeros(2*lx, 1)];
rxy = zeros(lag, 1); % create an empty column vector of rxy

%%%%%%% Not sure if we are allowed to use "sum" function.  %%%%%%%
%%%%%%% If not, please try version 2.                      %%%%%%%
%%%%%%%                 %%%%%%%
% version 1
for eta = 1:lag % implemented by "sum" and a for loop
    rxy(eta) = sum(x1.*y1(2*lx+1-eta:3*lx-eta)); % discrete CCF
end
%version 2
% for eta = 1:lag % implemented by 2 for loops.
%     s = 0;
%     for i = 1:lx
%         s = s + x1(i)*y1(2*lx-eta+i);
%     end
%     rxy(eta) = s;
% end

end
