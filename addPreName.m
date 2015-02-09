clear all
close all

path = 'data_1.21/A-E';
new_path = [path,'_sorted'];
if isdir(new_path)
    delete([new_path,'/*'])
else
    mkdir(new_path);    
end

list = dir([path,'/*.bmp']);
N = length(list);
wh = waitbar( 0,'frame handle' );
k=1;
for k=1:N
    I1 = imread([path,'/',list(k).name]);
    imwrite( I1,[new_path,'/frame',num2str(k),'.bmp'] ) ;        
    waitbar( (k)/N,wh,sprintf('ok:%d',k) )
end
close(wh)