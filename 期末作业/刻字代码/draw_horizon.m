%����ˮƽ�߹켣�ĺ�������������Ĳ����������꣬��ˮƽ��ʱthetaΪһ�����ƣ�phiΪһ�����顣
function horizon_line = draw_horizon(theta,phi,Ball)%Ball=[x,y,z,R]��Ϊ�������Ĳ���
    horizon_line = [
        Ball(4) * sin(phi) * cos(theta) + Ball(1); 
        Ball(4) * sin(phi) * sin(theta) + Ball(2); 
        Ball(4) * cos(zeros(1,length(theta))+phi) + Ball(3)
    ];
end