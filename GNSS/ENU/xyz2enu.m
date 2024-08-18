function enu = xyz2enu(xyz, origin)
X = origin(1);Y = origin(2);Z = origin(3);
% 1.坐标原点 xyz2blh
% 1.1求解经度
L = atan2(Y,X); % ***注意：当x<0时，看他的象限。 atan2 解决此问题
% 1.2求解纬度，迭代法
a = 6378137; % 地球长半径 可以根据坐标系的不同进行修改
e2 = 0.00669437999013; % 第一偏心率 e2 = f(2-f)

B0 = atan(Z/sqrt(X^2+Y^2)); % B0迭代的初值
B = 0;   % B的初值
while abs(B-B0) > 1e-13  % B0:初值
    N = a / sqrt(1-e2*(sin(B0))^2);
    B = atan((Z+N*e2*sin(B0))/sqrt(X^2+Y^2));
    B0 = B; % 更新下轮迭代的初值 
    % 也可以限制迭代次数 更改代码既可
end
% 1.3 求解大地高 一般不用
% H = Z/sin(B) - N(1-e2); 书上的公式   
% H = sqrt(X^2+Y^2)/cos(B) - N; 资料中的公式

%2. 坐标差 Δxyz2enu
dif = xyz - origin;  % 坐标差 xyz
S = [ -sin(L)          cos(L)          0;
      -sin(B)*cos(L)  -sin(B)*sin(L)  cos(B);
       cos(B)*sin(L)   cos(B)*sin(L)  sin(B); ]; % 坐标变化矩阵 抄书上的公式
enu =  S * dif.'; % 注意转置
end