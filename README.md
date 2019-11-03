# Distribution-Detection-and-Threshold-Segmentation
Random Computing Project_06

1. 对任意图像I，生成跟1一样大小的高斯分布或均匀分布矩阵w，选取固定强度值a，生成新的图像I′=I + w·a  
	生成同样大小的w，选取的a值可以是10~20之间的数值图像数目至少1000幅  
	对生成的图像I＇与模式w做相关性检测，得到r  
	对所有1，直接与w做相关性检测，得到s  
	计算r和s的分布，看看符合什么分布？  
	选择几幅图像，计算1，I＇的质量，采用PSNR和SSIM进行计算  
	自行寻找PSNR，SSIM的计算公式并实现  
2. 给定图像I，根据OTSU方法来确定图像二值化的阈值T  
  理解OTSU方法的本质  
  编程序求解出OTSU方法的阈值  
  显示图像二值化的结果  
