function [chunked_t_Accel,chunked_Accel] = TrimMotionData(MotionData,chunk_size,time_trim)
%TRIMMOTIONDATA Summary of this function goes here
Fs = MotionData.accel_rate; % in hertz
N = length(MotionData.t_Accel);

% FIlter data into 1 minute chunk
chunk_sz = chunk_size; % time in seconds
chunks = 10;
chunk_sz_index = round(chunk_sz * Fs);
front_trim = time_trim; % trim the first ten

% Trim the entire front
index_front = round(front_trim * Fs)+1;
MotionData.t_Accel = MotionData.t_Accel(index_front:end);
MotionData.t_Accel = MotionData.t_Accel - MotionData.t_Accel(1);
MotionData.Accel = MotionData.Accel(index_front:end, :);


chunked_Accel = {};
chunked_t_Accel = {};
for i=1:chunks
    begin_splice = (i-1)*chunk_sz_index+1;
    end_splice = (i)*chunk_sz_index;
    if end_splice > length(MotionData.t_Accel)
        break
    end
    % Chunk the data
    chunked_t_Accel{end + i} = MotionData.t_Accel(begin_splice:end_splice);
    chunked_Accel{end + i} = MotionData.Accel(begin_splice:end_splice, :);
    % Take a chunks worht of data
end
end
