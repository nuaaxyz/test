%% select images every
function sortImages()
categoryN = 4;

path = 'data_2.4/4A_L1_gray';

list = dir([path,'/*.bmp']);
images_num = length(list)
newList = changeFormat( list );

for i=1:categoryN
   newPath{i}  = [ path,'-',num2str(i) ];
   if isdir(newPath{i})
        delete([newPath{i},'/*'])
    else
        mkdir(newPath{i});    
    end
end

wh = waitbar( 0,'frame handle' );
for k=1:images_num
    I = imread( [ path,'/',list(k).name ] );
%     I = rgb2gray(I) ;
%     I = imadjust(I);
    
    subName_newPath = mod(k,categoryN) ;
    if subName_newPath==0
       subName_newPath = categoryN; 
    end
    imwrite( I,[ newPath{subName_newPath},'/',newList(k).name ] );
    
    waitbar( k/images_num, wh,sprintf('ok:%d',k) )
end
close(wh)

disp('OK')


function newList = changeFormat( list )

for i=1:length(list)
    N = length(list(i).name) ;
    list(i).name(N-2:N) = 'bmp';
end
newList = list ;



