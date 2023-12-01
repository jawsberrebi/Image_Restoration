%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Image Restauration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear all;
close all;

%% Open and display image 
B=imread('fichier2','bmp');                           
B=255*B;
figure(1);
image(B);
colormap("gray");

%% Autocorrelation

B_width = width(B);                                                         %%Loads the width of the picture
B_height = height(B);                                                       %%Loads the height of the picture

iterations = B_height-1;                                                    %%Number of iterations for the shifting of each line

shift_sum = 0;

final_image = zeros(B_height, B_width);                                     %%Initialization of the corrected picture
final_image(1,:) = B(1,:);

for i=1:iterations
    autocorr = xcorr(B(i+1,:),B(i,:));                                      %%Autocorrelation of the next line and the actual line
    [~, lag] = max(autocorr);                                               %%Stores the index of the maximum of the autocorrelation

    shift = B_width - lag;                                                  %%Computes the value of the shifting to do
    shift_sum = shift_sum + shift;                                          %%Adds it to the total sum of the shifting                                        

    shifted_row = circshift(B(i+1,:), shift_sum);                           %%Shifting of the samples of the next line
    final_image(i+1,:) = shifted_row;                                       %%Stores the shifted array in the corrected picture
end

%% Final display
figure(2);
image(final_image);
colormap("gray");
