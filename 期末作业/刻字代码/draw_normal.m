%计算普通线轨迹的函数，根据球面的参数方程坐标，画竖直时theta，phi均为数组。
function normal_line = draw_normal(theta,phi,Ball)%Ball=[x,y,z,R]，为输入的球的参数
    normal_line = [
            Ball(4) * sin(phi) .* cos(theta) + Ball(1); 
            Ball(4) * sin(phi) .* sin(theta) + Ball(2); 
            Ball(4) * cos(phi) + Ball(3)
    ];
end