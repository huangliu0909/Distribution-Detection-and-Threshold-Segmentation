clear;
imfinfo Boat.bmp;
I=imread('Boat.bmp');
imshow(I);
figure;imhist(I);
r = zeros(1,1000);
s = zeros(1,1000);
w = uint8(randn(256));
for i = 1:1000
    II = I;
    x = randi([1,256]);
    y = randi([1,256]);
    II(x, y) = II(x, y)+100;
    Ix = II + w * 15;              
    S = abs(fft2(II)); 
    r(i) = roundn((corr2(Ix,w)),-6) ;
    s(i) = roundn((corr2(II,w)),-6);
    
    if i == 1
        r_x(1) = r(i);
        s_x(1) = s(i);
        rnum(1) = 1;
        snum(1) = 1;
    else
        hasMention = 0;
        len = length(r_x);
        for k = 1:len
            if r_x(k) == r(i)
                hasMention = k;
                break;
            end
        end
        if hasMention == 0
            r_x(len + 1) = r(i);
            rnum(len + 1) = 1;
        else
            rnum(hasMention) = rnum(hasMention) + 1;
        end
        
        
        hasMention_s = 0;
        len_s = length(s_x);
        for k = 1:len_s
            if s_x(k) == s(i)
                hasMention_s = k;
                break;
            end
        end
        if hasMention_s == 0
            s_x(len_s + 1) = s(i);
            snum(len_s + 1) = 1;
        else
            snum(hasMention_s) = snum(hasMention_s) + 1;
        end
        
    end
    if i == 1
        X = II;
    end
    if i == 2
        Y = II;
    end
    if i == 3
        Z = II;
    end    
end
[rrx,rI] = sort(r_x)
rnum = rnum(rI)
[ssx,sI] = sort(s_x)
snum = snum(sI)

subplot(2,1,1);
bar(rrx,rnum)
subplot(2,1,2);
bar(ssx,snum)

T1=120;
for i=1:256
    for j=1:256
        if(I(i,j)<T1)
            BW1(i,j)=0;
        else 
            BW1(i,j)=1;
        end
    end
end
% figure;imshow(BW1),title('人工阈值进行分割');
T2=graythresh(I);%使用最大类间方差法找到图片的一个合适的阈值
BW2=im2bw(I,T2);%Otus阈值进行分割
figure;imshow(BW2),title('Otus阈值进行分割');
Psnr = {psnr(I,X)
psnr(I,Y)
psnr(I,Z)}

Ssim = {ssim(I,X)
ssim(I,Y)
ssim(I,Z)}


function [PSNR, MSE] = psnr(X, Y)
Y1=double(X);     
Y2=double(Y); 
if nargin<2       
    D = Y1;
else
    D = Y1 - Y2; 
end
MSE = sum(D(:).*D(:)) / numel(Y1);
PSNR = 10*log10(255^2 / MSE);
end

function[SSIM] = ssim(X,Y)
Y1=double(X);     
Y2=double(Y); 
k1 = 0.01;
k2 = 0.03;
L = 255;
C1 = (k1 * L)^2;
C2 = (k2 * L)^2;
C3 = C2/2;
mu1 = mean(mean(Y1));
mu2 = mean(mean(Y2));
mu12 = mean(mean(Y1 * Y2));
sigma1 = (std2(Y1))^2;
sigma2 = (std2(Y2))^2;
sigma1_2 = mu12 - mu1*mu2;
l = (2*mu1*mu2+C1)/(mu1^2+mu2^2+C1);
c = (2*sigma1*sigma2+C2)/(sigma1^2+sigma2^2+C2);
s = (sigma1_2+C3)/(sigma1*sigma2+C3);
SSIM = l * c * s;
end

