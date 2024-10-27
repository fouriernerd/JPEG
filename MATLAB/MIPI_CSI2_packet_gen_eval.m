rgbImage = imread('random_image.png'); % Load the random image
csi2Stream = generateCSI2Stream(rgbImage, 'RGB888'); % Test function with RGB888 format
disp(csi2Stream); % Display the generated CSI-2 stream
