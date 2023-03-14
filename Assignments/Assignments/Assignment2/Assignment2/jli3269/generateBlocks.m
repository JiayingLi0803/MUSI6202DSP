function [t, x_blk] = generateBlocks(x, sample_rate_hz, block_size, hop_size)

block_num = ceil((length(x)-(block_size-hop_size))/hop_size); % find block number
x = [x; zeros(mod(length(x)-block_size,hop_size), 1)]; % zero pad x for the last block
x_blk = zeros(block_size,block_num); % initialize x_blk matrix
t = zeros(block_num,1); % initialize t
for i = 1:block_num
    x_blk(:, i) = x(hop_size*(i-1)+1:hop_size*(i-1)+block_size); % copy blocks of x into x_blk matrix
    t(i) = hop_size*(i-1)/sample_rate_hz; % use time stamp
end
end