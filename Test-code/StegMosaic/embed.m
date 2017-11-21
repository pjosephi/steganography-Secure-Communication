function [img] = embed( img,msg )
%grouping the pixel pairs
len = length(msg);
% msg = mg(1:len - 1);
imgsize = size(img);
p = (imgsize(1)*imgsize(2)*3)/2;
% msgnew = [];
% if len > p
%     error('wrong!');
% else
for i = 1:262144
    msg(len+i) = 0;
end
% end
num = 1;
for iter = 1 : 15
    wm = msg((iter - 1) * p + 1 : iter * p);
    for k = 1:3
    Img = img(:,:,k);
    [rows,cols]=size(Img);
    m = wm(1+(k-1)*p/3:k*p/3);
    n = 1;
    for i=1:rows
        for j = 1:2:cols
            a=double(Img(i,j));
            b=double(Img(i,j+1));
            if ((0<=(2*a-b)<=255)&&(0<=(2*b-a)<=255)) && ((bitget(Img(i,j),1)==0)&&(bitget(Img(i,j+1),1)==0))
                Img(i,j)=2*a-b;
                Img(i,j+1)=2*b-a;
                Img(i,j)=bitset(Img(i,j),1,1);
                Img(i,j+1)=bitset(Img(i,j),1,m(n));
            %msgnew(num+(k-1)*rows*cols)=msg(num);
                n = n+1;
            else if ((0<=(2*a-b)<=255)&&(0<(2*b-a)<=255)) && ((bitget(Img(i,j),1)==1)||(bitget(Img(i,j+1),1)==1))
                Img(i,j)=bitset(Img(i,j),1,0);
             %message = str2num(msg(i+(k-1)*length(pixels)));
                Img(i,j+1)=bitset(Img(i,j+1),1,m(n));
             %msgnew(num+(k-1)*rows*cols)=msg(num);
                n = n+1;
            else
                fprintf('yes');
                %msgnew(num)=bitget(Img(i,j+1),1); %#ok<AGROW>
                Img(i,j)=bitset(Img(i,j),1,0);
                n = n + 1;
                num = num + 1;
                end
            end
        end
    end
%x3=Img';
%x4=x3(:);
%x5=buffer(x4,rows);
%result(:,:,k) = x5;

%result = uint8(result);
%imshow(result);
    img(:,:,k) = Img;
    end
end
%imwrite(embedimg, 'C:\result\mosaic.jpg','jpg');
end