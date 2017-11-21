function [exmsg,img] = extract( img,wmnew,len )
%1.grouping the pixel pairs
for k = 1:3
Img = img(:,:,k);
[rows,cols]=size(Img);
%y1=Img(:);
%y2=buffer(y1,2);
%expixels=y2';
num = 1;
n = 1;
p = ((k-1)*rows*cols)/2;
for i=1:rows
    for j = 1:2:cols
        a = double(bitset(Img(i,j),1,0));
        b = double(bitset(Img(i,j+1),1,0));
        c = double(bitset(Img(i,j),1,1));
        d = double(bitset(Img(i,j+1),1,1));
        if(bitget(Img(i,j),1)==1)
            extractedwm(num+p)=double(bitget(Img(i,j+1),1));
            Img(i,j)=ceil((2*a+b)/3);
            Img(i,j+1)=ceil((2*b+a)/3);
            num = num+1;
        else if ((bitget(Img(i,j),1)==0) && (0<=(2*c-d)<=255 && 0<=(2*d-c)<=255))
            extractedwm(num+p)=double(bitget(Img(i,j+1),1));
            Img(i,j)=bitset(Img(i,j),1,1);
            Img(i,j+1)=bitset(Img(i,j+1),1,1);
            num = num+1;
            else
                Img(i,j)=bitset(Img(i,j),1,wmnew(n));
                n = n+1;
            end
        end
    end
    img(:,:,k) = Img;
end
%result = uint8(result);
%imshow(result);
%imwrite(img, 'C:\result\extract.jpg','jpg');
%title('extracted image');
end
exmsg = extractedwm(1:len);
%imwrite(img, 'extract.jpg','jpg');
end


