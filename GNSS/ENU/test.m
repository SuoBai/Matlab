clear;clc;close all;
%1. �������ļ�-->enu����
fileName = 'C:\Users\�ɷ�\Desktop\960\RTK\2024-05-20-14.txt';  %�Լ�����
trueXYZ = nan(1,3);  % �洢��վ��������ֵ
fid = fopen(fileName,'r');
if fid == -1
    error('File could not be opened');
end
line = fgetl(fid); % ��ȡһ��

%1.1 ����λ�ļ��������Լ����ļ���ʽ����
while ~contains(line, "586*70")
    line = fgetl(fid);
end   

%1.2 ��Ŀ���վ
while ~contains(line, "SAVE LIST")
    line = fgetl(fid);
end   
%1.3 ������
for i=1:3
    res = split(line); % res��һ��Ԫ��
    trueXYZ(i) = str2double(res{10}); % ��Ԫ��
    line = fgetl(fid); % �� xyz����һ�ζ���
end
fclose(fid);    % �ر��ļ�����д��� 

%2. ����λ���ļ�
fileName2 = 'C:\Users\�ɷ�\Desktop\Test\8.8\rtk.pos';
fid2 = fopen(fileName2, 'r');

if fid2 == -1
    error('File could not be opened');
end

%2.1 ������
times = 3032; % ��������
enuAll = nan(times, 3);  % �洢����ת�����enu����
for i=1:times
    line1 = fgetl(fid2);
    if isempty(line1); continue; end  % ȥ������
    res2 = split(line1);
    x = str2double(res2{3});
    y = str2double(res2{4});
    z = str2double(res2{5});
    % 2.2 xyzתΪenu->���չ�ʽ
    enuAll(i,:) = xyz2enu([x y z], trueXYZ);
end
fclose(fid2); 

%3 ��ͼ
figure;hold on;
plot(1:times, enuAll(:,1), 'r', 'LineWidth', 2);
plot(1:times, enuAll(:,2), 'g', 'LineWidth', 2);
plot(1:times, enuAll(:,3), 'b', 'LineWidth', 2);









