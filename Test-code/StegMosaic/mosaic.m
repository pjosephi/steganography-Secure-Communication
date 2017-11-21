clc
clear all

img_1 = 'Soldier.jpg';
img_2 = 'Family2.jpg';
img_size = [512,512];
subimg_size = 2;
list_1 = split(img_1,subimg_size);
list_2 = split(img_2,subimg_size);
[s_list,s_index] = img_sort(list_1);
[t_list,t_index] = img_sort(list_2);
[list, output] = color_transfer( s_index,t_index,list_1,list_2,img_size, subimg_size );
result = substitute( t_index,subimg_size,list );
imshow(result);
imwrite(result, 'Steg.jpg','jpg');
%output = flow( s_index,t_index,list_1,list_2,img_size,subimg_size );
% len = length(output);
% [embed] = embed( result,output );
% %imshow(embed)
% [exmsg, img] = extract( embed,len );
info = info_extract( result,subimg_size,output );
recover_list = color_retrans( info,result,subimg_size );
recovery( result,subimg_size,recover_list,s_index );

