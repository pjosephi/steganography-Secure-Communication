function [msgnew,embedimg] = embed( img,msg )
%grouping the pixel pairs
len = length(msg);
imgsize = size(img);
p = (imgsize(1)*imgsize(2)*3)/2;
msgnew = [];
%Моід
if len > p
    error('wrong!');
else
    for i = 1:(p-len)
        msg(len+i) = 0;
    end
end
num = 1;
for k = 1:3
Img = img(:,:,k);
[rows,cols]=size(Img);
wm = msg(1+(k-1)*p/3:k*p/3);
%embed = zeros(rows,cols);
%x1=Img(:);
%x2=buffer(x1,2);
%pixels=x2';
%[row1,cols1]=size(pixels);
%len = length(msg);
%watermark bit generation
%msg =randsrc(rows*cols/2,1,[0 1]);
n = 1;
for i=1:rows
    for j = 1:2:cols
        a=double(Img(i,j));
        b=double(Img(i,j+1));
        if ((0<=(2*a-b)<=255)&&(0<=(2*b-a)<=255)) && ((bitget(Img(i,j),1)==0)&&(bitget(Img(i,j+1),1)==0))
            Img(i,j)=2*a-b;
            Img(i,j+1)=2*b-a;
            Img(i,j)=bitset(Img(i,j),1,1);
            Img(i,j+1)=bitset(Img(i,j),1,wm(n));
            %msgnew(num+(k-1)*rows*cols)=msg(num);
            n = n+1;
    else if ((0<=(2*a-b)<=255)&&(0<(2*b-a)<=255)) && ((bitget(Img(i,j),1)==1)||(bitget(Img(i,j+1),1)==1))
             Img(i,j)=bitset(Img(i,j),1,0);
             %message = str2num(msg(i+(k-1)*length(pixels)));
             Img(i,j+1)=bitset(Img(i,j+1),1,wm(n));
             %msgnew(num+(k-1)*rows*cols)=msg(num);
             n = n+1;
        else
            Img(i,j)=bitset(Img(i,j),1,0);
            msgnew(num)=bitget(Img(i,j+1),1);
            n = n+1;
            num = num+1;
        end
    end
end
%x3=Img';
%x4=x3(:);
%x5=buffer(x4,rows);
%result(:,:,k) = x5;
end
%result = uint8(result);
%imshow(result);
embedimg(:,:,k) = Img;
end
imwrite(embedimg, 'C:\result\mosaic.jpg','jpg');
end