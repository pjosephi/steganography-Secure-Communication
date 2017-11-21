function [mag, pha] = FFT( cover_img, secret_img, p, q )
cover_imgsize = size(cover_img);
secret_imgsize = size(secret_img);
S = cover_imgsize(1) * cover_imgsize(2);
fft = fft2(cover_img);
mag = abs(fft);
pha = angle(fft);

info = '';
for i = 1:secret_imgsize(1)
    for j = 1:secret_imgsize(2)
        info = [info, dec2bin(secret_img(i,j), 8)];
    end
end


m = 1;
Z = zeros(cover_imgsize(1), cover_imgsize(2));
for i = 1:cover_imgsize(1)
    for j = 1:cover_imgsize(2)
        n = j + cover_imgsize(1) * (i - 1);
        Z(i,j) = mod((p * n + 1 - q), S);
            first = str2double(info(m));
            second = str2double(info(m + 1));
            m = m + 2;
            if mod(Z(i,j), 2) == 0
                temp1 = typecast(mag(i,j), 'uint64');
                temp1 = bitset(temp1,1,first);
                temp1 = bitset(temp1,3,second);
                mag(i,j) = typecast(temp1, 'double');
            else
                temp2 = typecast(pha(i,j), 'uint64');
                temp2 = bitset(temp2,1,first);
                temp2 = bitset(temp2,3,second);
                pha(i,j) = typecast(temp2, 'double');
            end
    end
end
end

