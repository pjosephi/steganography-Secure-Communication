function [exmsg,img] = extract( img,len,wmnew )
n = 1;
for iter = 1 : 15
    num = 1;
%1.grouping the pixel pairs
    for k = 1:3
    Img = img(:,:,k);
    [rows,cols]=size(Img);
    %p = ((k-1)*rows*cols)/2;
    for i=1:rows
        for j = 1:2:cols
            p = Img(i,j);
            q = Img(i,j+1);
            a = double(bitset(p,1,0));
            b = double(bitset(q,1,0));
            c = double(bitset(p,1,1));
            d = double(bitset(q,1,1));
            if(bitget(Img(i,j),1)==1)
                extractedwm(num)=double(bitget(Img(i,j+1),1));
                Img(i,j)=ceil((2*a+b)/3);
                Img(i,j+1)=ceil((2*b+a)/3);
                num = num+1;
            else if ((bitget(Img(i,j),1)==0) && (0<=(2*c-d)<=255 && 0<=(2*d-c)<=255))
                extractedwm(num)=double(bitget(Img(i,j+1),1));
                Img(i,j)=bitset(Img(i,j),1,1);
                Img(i,j+1)=bitset(Img(i,j+1),1,1);
                num = num+1;
            else
                Img(i,j)=bitset(Img(i,j),1,0);
                n = n+1;
                num = num + 1;
                end
            end
        end
    end
    img(:,:,k) = Img;
    end
    start = 393216 * (15 - iter) + 1;
    tail = 393216 * (16 - iter);
    exmsg(start:tail) = extractedwm;
end
exmsg = exmsg(1:len);
%imwrite(img, 'extract.jpg','jpg');
end


