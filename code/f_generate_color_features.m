function features  = f_generate_color_features( roi )

    %assuming roi image is 32 X 32
    %[h,w] = size(roi);
    %h2 = ceil(h/8);
    %w2 = ceil(w/8);
   
    %number of bins for histogram
    numBins = 10;
    
    %init hue and saturation histogram space
    %hueHist = zeros(h2*w2*numBins,1);
    %satHist = zeros(h2*w2*numBins,1);
    
    %convert rgb roi to hsv
    hsvRoi = rgb2hsv(roi);
    
    hueMat = hsvRoi(:,:,1);
    satMat = hsvRoi(:,:,2);
    
    hueFun = @(block_struct) histcounts(block_struct.data, numBins);
    satFun = @(block_struct) histcounts(block_struct.data, numBins);
    
    hueHist = blockproc(hueMat, [8,8], hueFun);
    satHist = blockproc(satMat, [8,8], satFun);
    
    hueHist = hueHist';
    satHist = satHist';
    
    features = [hueHist(:), satHist(:)];
    features = features(:);
end
