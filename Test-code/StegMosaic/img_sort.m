function [ output,index ] = img_sort( list )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
img_num = length(list);%获取图像总数量
for j = 1:img_num %逐一读取图像
    image = list{j};
    a(j) = std2(image(:,:,2));
end
[output,index] = sort(a);
end
