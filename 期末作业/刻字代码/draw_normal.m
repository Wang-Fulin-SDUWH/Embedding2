%������ͨ�߹켣�ĺ�������������Ĳ����������꣬����ֱʱtheta��phi��Ϊ���顣
function normal_line = draw_normal(theta,phi,Ball)%Ball=[x,y,z,R]��Ϊ�������Ĳ���
    normal_line = [
            Ball(4) * sin(phi) .* cos(theta) + Ball(1); 
            Ball(4) * sin(phi) .* sin(theta) + Ball(2); 
            Ball(4) * cos(phi) + Ball(3)
    ];
end