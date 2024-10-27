function csi2Stream = generateCSI2Stream(rgbImage, format)
    % Input:
    % rgbImage - MxNx3 matrix of RGB values (e.g., from imread)
    % format - 'RGB888' or 'RGB565'

    % Output:
    % csi2Stream - Simulated MIPI CSI-2 stream as a byte array

    [rows, cols, ~] = size(rgbImage);
    csi2Stream = []; % Initialize the byte stream array

    for r = 1:rows
        for c = 1:cols
            pixel = squeeze(rgbImage(r, c, :)); % Extract RGB values
            switch format
                case 'RGB888'
                    % Pack as 24-bit RGB888
                    packet = uint8([hex2dec('2B'), pixel(1), pixel(2), pixel(3)]); % 2B: RGB888 data type ID in CSI-2
                case 'RGB565'
                    % Pack as 16-bit RGB565
                    r5 = bitshift(bitand(pixel(1), 0xF8), -3);
                    g6 = bitshift(bitand(pixel(2), 0xFC), -2);
                    b5 = bitshift(bitand(pixel(3), 0xF8), -3);
                    pixelData = bitor(bitor(bitshift(r5, 11), bitshift(g6, 5)), b5);
                    packet = uint8([hex2dec('22'), typecast(uint16(pixelData), 'uint8')]); % 22: RGB565 data type ID
            end
            
            % Append packet to the stream
            csi2Stream = [csi2Stream, packet];
        end
    end
end
