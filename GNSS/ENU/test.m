clear;clc;close all;
%1. 读坐标文件-->enu坐标
fileName = 'C:\Users\飞飞\Desktop\960\RTK\2024-05-20-14.txt';  %自己输入
trueXYZ = nan(1,3);  % 存储测站的坐标真值
fid = fopen(fileName,'r');
if fid == -1
    error('File could not be opened');
end
line = fgetl(fid); % 读取一行

%1.1 读定位文件，根据自己的文件格式解析
while ~contains(line, "586*70")
    line = fgetl(fid);
end   

%1.2 找目标测站
while ~contains(line, "SAVE LIST")
    line = fgetl(fid);
end   
%1.3 读坐标
for i=1:3
    res = split(line); % res是一个元胞
    trueXYZ(i) = str2double(res{10}); % 解元胞
    line = fgetl(fid); % 将 xyz坐标一次读出
end
fclose(fid);    % 关闭文件，读写完成 

%2. 读定位解文件
fileName2 = 'C:\Users\飞飞\Desktop\Test\8.8\rtk.pos';
fid2 = fopen(fileName2, 'r');

if fid2 == -1
    error('File could not be opened');
end

%2.1 读坐标
times = 3032; % 数据总数
enuAll = nan(times, 3);  % 存储所有转换后的enu坐标
for i=1:times
    line1 = fgetl(fid2);
    if isempty(line1); continue; end  % 去除空行
    res2 = split(line1);
    x = str2double(res2{3});
    y = str2double(res2{4});
    z = str2double(res2{5});
    % 2.2 xyz转为enu->依照公式
    enuAll(i,:) = xyz2enu([x y z], trueXYZ);
end
fclose(fid2); 

%3 作图
figure;hold on;
plot(1:times, enuAll(:,1), 'r', 'LineWidth', 2);
plot(1:times, enuAll(:,2), 'g', 'LineWidth', 2);
plot(1:times, enuAll(:,3), 'b', 'LineWidth', 2);









