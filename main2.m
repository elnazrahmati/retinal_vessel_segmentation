close all; clear; clc;

image_path = 'E:\term6\machine vision\HW\HW4\DRIVE\Test\images\';
mask_path = 'E:\term6\machine vision\HW\HW4\DRIVE\Test\mask\';
result_path = 'E:\term6\machine vision\HW\HW4\DRIVE\Test\1st_manual\';
A = zeros(21,3);
for i = 1:9
    I = im2double(imread([image_path '0' num2str(i) '_test.tif']));
    mask = im2double(imread([mask_path '0' num2str(i) '_test_mask.gif']));
    result = im2double(imread([result_path '0' num2str(i) '_manual1.gif']));
    T = retinal_vessel_segmentation(I,mask);
    imwrite(T,[result_path '0' num2str(i) '_result.tif']);
    A(i,1) = 1 - sum(sum(abs(result - T)))/(584*565);%accuracy
    A(i,2) = sum(sum(result .* T))/ sum(sum(result));%sensitivity
    A(i,3) = sum(sum((1-result) .* (1-T))) / sum(sum(1-result));%sec...
end
for i = 10:20
    I = im2double(imread([image_path num2str(i) '_test.tif']));
    mask = im2double(imread([mask_path num2str(i) '_test_mask.gif']));
    result = im2double(imread([result_path num2str(i) '_manual1.gif']));
    T = retinal_vessel_segmentation(I,mask);
    imwrite(T,[result_path num2str(i) '_result.tif']);
    A(i,1) = 1 - sum(sum(abs(result - T)))/(584*565);%accuracy
    A(i,2) = sum(sum(result .* T))/ sum(sum(result));%sensitivity
    A(i,3) = sum(sum((1-result) .* (1-T))) / sum(sum(1-result));%Specificity
end

average = sum(A)/20;
A(21,1) = average(1);
A(21,2) = average(2);
A(21,3) = average(3);
path = 'E:\term6\machine vision\HW\HW4\retinal_results.xlsx';
% xlswrite(path,A);
