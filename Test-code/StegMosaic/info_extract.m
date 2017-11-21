function info = info_extract( img,subimg_size,msg )
imgsize = size(img);
num = (imgsize(1)*imgsize(2)) / subimg_size^2;
len = log2(num) + 70;
a = buffer(msg,len);
info = [];
%提取信息
for i = 1:num
    b = a(:,i);
    m = b';
    index = num2str(m(1:log2(num)+1));
    index = bin2dec(index);
    s_ave_r = num2str(m(log2(num)+2:log2(num)+9));
    s_ave_g = num2str(m(log2(num)+10:log2(num)+17));
    s_ave_b = num2str(m(log2(num)+18:log2(num)+25));
    t_ave_r = num2str(m(log2(num)+26:log2(num)+33));
    t_ave_g = num2str(m(log2(num)+34:log2(num)+41));
    t_ave_b = num2str(m(log2(num)+42:log2(num)+49));
    s_ave = [bin2dec(s_ave_r),bin2dec(s_ave_g),bin2dec(s_ave_b)];
    t_ave = [bin2dec(t_ave_r),bin2dec(t_ave_g),bin2dec(t_ave_b)];
    q_r = num2str(m(log2(num)+50:log2(num)+56));
    q_g = num2str(m(log2(num)+57:log2(num)+63));
    q_b = num2str(m(log2(num)+64:log2(num)+70));
    q = [bin2dec(q_r),bin2dec(q_g),bin2dec(q_b)];
    info = [info,index,s_ave,t_ave,q];
end

end

