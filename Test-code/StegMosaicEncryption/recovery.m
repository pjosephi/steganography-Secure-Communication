function recovery( img,subimg_size,list,s_index )
imgsize = size(img);
num = (imgsize(1)*imgsize(2)) / subimg_size^2;
width_num = imgsize(1) / subimg_size;
recover_img = zeros(imgsize(1),imgsize(2));
for i = 1:num
    row = ceil(s_index(i) / width_num);
    clm = s_index(i) - width_num * (ceil(s_index(i) / width_num) - 1);
    y = (clm - 1) * subimg_size + 1;
    for n = 1:subimg_size
        x = (row - 1) * subimg_size + 1;
        for m = 1:subimg_size
            for k = 1:3
                channel = list{i}(m,n,k);
                recover_img(x,y,k) = channel;
            end
            x = x + 1;
        end
        y = y + 1;
    end
end
recover_img = uint8(recover_img);
imshow(recover_img);
imwrite(recover_img, 'Recovered.jpg','jpg');
end

