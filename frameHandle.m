clear all
close all

isJudgeCorners = 0;

path = 'stereo/2.4B-double';

new_path = [path,'_gray'];
if isdir(new_path)
    delete([new_path,'/*'])
else
    mkdir(new_path);    
end

list = dir([path,'/*.png']);
N = length(list);
wh = waitbar( 0,'frame handle' );
k=1;
invald_k=0;
invalid_name=cell(2,1);
while (k+invald_k)<=N
    I1 = imread([path,'/',list(k+invald_k).name]);
    I2 = rgb2gray(I1) ;
    I2 = imadjust(I2);
    
    if isJudgeCorners==1
    
        BWCrossIn = xyz_findEdgeCorners( I2,[],[],15,1 );

        if ~isempty(BWCrossIn)        
            imwrite( I2,[new_path,'/frame',num2str(k+151),'.bmp'] ) ;        
            sprintf( '%s ok',list(k).name );
            k = k+1 ;
        else
            sprintf('%s invalid!',list(k).name);
            invald_k = invald_k+1 ;
            invalid_name{invald_k}=list(k).name;
        end

    else
        imwrite( I2,[new_path,'/frame',num2str(k+151),'.bmp'] ) ;        
        sprintf( '%s ok',list(k).name );
        k = k+1 ;
    end
    waitbar( (k+invald_k)/N,wh,sprintf('ok:%d¡£ invalid:%d',k,invald_k) )
end
close(wh)
sprintf('ok:%d¡£ invalid:%d',k,invald_k)
invalid_name
return;

list = dir([path,'/*.png']);
I1 = imread([path,'/',list(1).name]);
I1 = rgb2gray(I1) ;
figure,imshow(I1)

I1 = imadjust(I1);
figure,imshow(I1)

level=graythresh(I1);
I2=im2bw(I1,0.85);
I3=~I2;
I4=bwareaopen(I3,50);
I5=~I4;
figure,imshow(I5)

return;
