function [ output,index ] = img_sort( list )
img_num = length(list);
for j = 1:img_num 
    image = list{j};
    a(j) = std2(image(:,:,2));
end
[output,index] = sort(a);
end
