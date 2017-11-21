function result = substitute( index,subimg_size,list )
img_num = length(list);
result = zeros(512,512);
width_num = 512 / subimg_size;
for i = 1:img_num
    image = list{i};
    row = ceil(index(i) / width_num);
    clm = index(i) - width_num * (ceil(index(i) / width_num) - 1);
    y = (clm - 1) * subimg_size + 1;
    for n = 1:subimg_size
        x = (row - 1) * subimg_size + 1;
        for m = 1:subimg_size
            for k = 1:3
                channel = image(m,n,k);
                result(x,y,k) = channel;
            end
            x = x + 1;
        end
        y = y + 1;
    end
end

result = uint8(result);
%imshow(result);
%imwrite(result, 'C:\result\result.jpg','jpg');
end

