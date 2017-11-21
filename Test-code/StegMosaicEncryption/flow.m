function [ output ] = flow( s_index,t_index,s_list,t_list,img_size,subimg_size )
img_num = length(s_list);
n = log2((img_size(1)*img_size(2)) / subimg_size^2) + 1;
message = '';
for i = 1:img_num
    msg_1 = dec2bin(t_index(i),n);
    if length(msg_1) ~= n
        fprintf('No.%d\n',i);
    end
    s_ave = round(mean(mean(s_list{s_index(i)})));
    t_ave = round(mean(mean(t_list{t_index(i)})));
    s_dev_r = std2(s_list{s_index(i)}(:,:,1));
    s_dev_g = std2(s_list{s_index(i)}(:,:,2));
    s_dev_b = std2(s_list{s_index(i)}(:,:,3));
    t_dev_r = std2(t_list{t_index(i)}(:,:,1));
    t_dev_g = std2(t_list{t_index(i)}(:,:,2));
    t_dev_b = std2(t_list{t_index(i)}(:,:,3));
    q_r = round((t_dev_r / s_dev_r)*10);
    q_g = round((t_dev_g / s_dev_g)*10);
    q_b = round((t_dev_b / s_dev_b)*10);
    if s_ave(1)>255
        s_ave(1) = 255;
    else if s_ave(2)>255
            s_ave(2) = 255;
        else if s_ave(3) >255
                s_ave(3) = 255;
            end
        end
    end
    msg_2 = dec2bin(s_ave(1),8);
    if length(msg_2) ~= 8
        fprintf('s_ave_r %d\n',i);
    end
    msg_3 = dec2bin(s_ave(2),8);
    if length(msg_3) ~= 8
        fprintf('s_ave_g %d\n',i);
    end
    msg_4 = dec2bin(s_ave(3),8);
    if length(msg_4) ~= 8
        fprintf('s_ave_b %d\n',i);
    end
    if t_ave(1)>255
        t_ave(1) = 255;
    else if t_ave(2)>255
            t_ave(2) = 255;
        else if t_ave(3) >255
                t_ave(3) = 255;
            end
        end
    end
    msg_5 = dec2bin(t_ave(1),8);
    if length(msg_5) ~= 8
        fprintf('t_ave_r %d\n',i);
    end
    msg_6 = dec2bin(t_ave(2),8);
    if length(msg_6) ~= 8
        fprintf('t_ave_g %d\n',i);
    end
    msg_7 = dec2bin(t_ave(3),8);
    if length(msg_7) ~= 8
        fprintf('t_ave_b %d\n',i);
    end
    if q_r>127
        q_r = 127;
    else if q_g>127
            q_g = 127;
        else if q_b>127
                q_b = 127;
            end
        end
    end
    msg_8 = dec2bin(q_r,7);
    if length(msg_8) ~= 7
        fprintf('q_r %d\n',i);
        msg_8 = '1111111';
    end
    msg_9 = dec2bin(q_g,7);
    if length(msg_9) ~= 7
        fprintf('q_g %d\n',i);
        msg_9 = '1111111';
    end
    msg_10 = dec2bin(q_b,7);
    if length(msg_10) ~= 7
        fprintf('q_b %d\n',i);
        msg_10 = '1111111';
    end
    msg = [msg_1,msg_2,msg_3,msg_4,msg_5,msg_6,msg_7,msg_8,msg_9,msg_10];
    message = [message,msg];
end
for j = 1:img_num*(n+48+21)
    output(j) = str2num(message(j));
end
end

