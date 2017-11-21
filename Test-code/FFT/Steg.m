cover_img_name = 'peppers.png';
secret_img_name = 't.png';
cover_img = im2double(imread(cover_img_name));
secret_img = imread(secret_img_name);
cover_imgsize = size(cover_img);
secret_imgsize = size(secret_img);
S = cover_imgsize(1) * cover_imgsize(2);

p = round(rand(1) * S);
while(gcd(S,p) ~= 1)
    p = round(rand(1) * S);
end

q = round(rand(1) * S);
while(gcd(S,q) ~= 1)
    q = round(rand(1) * S);
end

%Embed process
[I_mag_red, I_pha_red] = FFT(cover_img(:,:,1), secret_img(:,:,1), p, q);
red = I_mag_red.*exp(1i*I_pha_red);
R = real(ifft2(red));
[I_mag_green, I_pha_green] = FFT(cover_img(:,:,2), secret_img(:,:,2), p, q);
green = I_mag_green.*exp(1i*I_pha_green);
G = real(ifft2(green));
[I_mag_blue, I_pha_blue] = FFT(cover_img(:,:,3), secret_img(:,:,3), p, q);
blue = I_mag_blue.*exp(1i*I_pha_blue);
B = real(ifft2(blue));
img = zeros(cover_imgsize(1),cover_imgsize(2),3);
img(:,:,1) = R;
img(:,:,2) = G;
img(:,:,3) = B;
%img = im2uint8(img);
%imshow(img);
imwrite(img, 'result.png', 'png');