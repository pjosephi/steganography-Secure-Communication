function [ output,index ] = img_sort( list )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img_num = length(list);%��ȡͼ��������
for j = 1:img_num %��һ��ȡͼ��
    image = list{j};
    a(j) = std2(image(:,:,2));
end
[output,index] = sort(a);
end
