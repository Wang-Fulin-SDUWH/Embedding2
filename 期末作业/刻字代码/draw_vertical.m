%���㴹ֱ�߹켣�ĺ�������������Ĳ����������꣬����ֱʱthetaΪһ����ֵ��phiΪһ�����顣
function vertical_line = draw_vertical(theta,phi,Ball)%Ball=[x,y,z,R]��Ϊ�������Ĳ���
    vertical_line = [
        Ball(4) * sin(phi) * cos(theta) + Ball(1); 
        Ball(4) * sin(phi) * sin(theta) + Ball(2); 
        Ball(4) * cos(zeros(1,length(theta))+phi) + Ball(3);
    ];
end