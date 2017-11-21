function [ output ] = split( Img,subimg_size )
%Img=imread(img_name);
imgsize=size(Img);
subimg_width=subimg_size;
subimg_height=subimg_size;
num_height_spilt=ceil(imgsize(1)/subimg_height);
num_width_spilt=ceil(imgsize(2)/subimg_width);
%num=num_width_spilt*num_height_spilt;
for i=1:num_height_spilt
    for j=1:num_width_spilt
        if(i*subimg_height<=imgsize(1))
            height=subimg_height;
        else
            height=imgsize(1)-(i-1)*subimg_height;
        end
        if(j*subimg_width<=imgsize(2))
            width=subimg_width;
        else
            width=imgsize(2)-(j-1)*subimg_width;
        end
        subimg=zeros(height,width);
        for ii=1:height
            for jj=1:width
                for kk=1:3
                    subimg(ii,jj,kk)=Img((i-1)*subimg_height+ii,(j-1)*subimg_width+jj,kk);
                end
            end
        end
        subimg=uint8(subimg);
        output{(i-1)*num_width_spilt+j} = subimg;
    end
end

