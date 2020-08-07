function output_image = retinal_vessel_segmentation(input_image,input_mask)
    input_size = size(input_image);
    J = reshape(input_image(:,:,2),input_size(1), input_size(2));%exracting green channel
    J = 1 - J;%negative
    J = J .* input_mask;
    k = fspecial('average',[25 25]);%makeing average kernel
    J = J + (1-input_mask);%changeing background color from B to W
    K = imfilter(J,k);%filtering with average kernel
    J = J .* input_mask;
    K = K .* input_mask;
    BW1 = (J>1.015*K);%binarizeing image using K as threshold
    BW = medfilt2(BW1, [3 3]);%denoising step 1
    %denoising step 2:
    labeled_image = bwlabel(BW);
    n = max(max(labeled_image));
    output_image = BW;
    for i = 1:n
       mask = (labeled_image == i); 
       surface = sum(sum(mask));
       if surface<120
           output_image = output_image .* (1-mask);
       end
    end

end