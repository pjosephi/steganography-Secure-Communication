clc
clear all

img_1 = 'Encoded.jpg';
img_2 = 'Lena.tiff';
img_size = [512,512];
subimg_size = 8;
list_1 = split(img_1,subimg_size);
list_2 = split(img_2,subimg_size);
[s_list,s_index] = img_sort(list_1);
[t_list,t_index] = img_sort(list_2);
list = color_transfer( s_index,t_index,list_1,list_2,subimg_size );
result = substitute( t_index,subimg_size,list );
imshow(result);
imwrite(result, '2016.jpg','jpg');
output = flow( s_index,t_index,list_1,list_2,img_size,subimg_size );
len = length(output);
[msgnew,embed] = embed( result,output );
[exmsg,img] = extract( embed,msgnew,len );
info = info_extract( img,subimg_size,exmsg );
recover_list = color_retrans( info,img,subimg_size );
recovery( img,subimg_size,recover_list,s_index );

