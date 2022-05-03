%计算水平线轨迹的函数，根据球面的参数方程坐标，画水平线时theta为一个定制，phi为一个数组。
function horizon_line = draw_horizon(theta,phi,Ball)%Ball=[x,y,z,R]，为输入的球的参数
    horizon_line = [
        Ball(4) * sin(phi) * cos(theta) + Ball(1); 
        Ball(4) * sin(phi) * sin(theta) + Ball(2); 
        Ball(4) * cos(zeros(1,length(theta))+phi) + Ball(3)
    ];
end