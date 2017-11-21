function output = color_retrans( info,img,subimg_size )
imgsize = size(img);
num = (imgsize(1)*imgsize(2)) / subimg_size^2;
width_num = imgsize(1) / subimg_size;
for j = 1:num
    n = info((j-1)*10+1);
    row = ceil(n / width_num);
    cln = n - width_num * (row - 1);
    y = (cln - 1) * subimg_size + 1;
    for height = 1:subimg_size
        x = (row - 1) * subimg_size + 1;
        for width = 1:subimg_size
            for k = 1:3
                channel = img(x,y,k);
                subimage(width,height,k) = (channel - info((j-1)*10+k+4))*(10 / info((j-1)*10+k+7)) + info((j-1)*10+k+1);
            end
            x = x + 1;
        end
        y = y + 1;
    end
   subimage=uint8(subimage);
   output{j} = subimage;
end
end

