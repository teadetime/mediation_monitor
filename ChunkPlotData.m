function [time,accel] = ChunkPlotData(datafile,chunk_size,start_time)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[MotionData]=ParseMatlabApp(datafile);
figure(1)
plot(MotionData.t_Accel, MotionData.Accel)
time_left = MotionData.t_Accel(end);
i = 1;
time = {}
accel = {}
while time_left - chunk_size > 0
[chunked_t_Accel,chunked_Accel] = TrimMotionData(MotionData,chunk_size,start_time);
chunked_t_Accel = chunked_t_Accel{1};
chunked_Accel = chunked_Accel{1};
time{i} = chunked_t_Accel;
accel{i} = chunked_Accel;
% Data.chunked_Accel(i:i+1) = chunked_Accel;
i = i + 1
time_left = time_left - chunk_size;
start_time = start_time + chunk_size;
end
end

