function exp_array=expand_array(node_x,node_y,node_z,gn,xTarget,yTarget,zTarget,CLOSED,xB1,xB2,yB1,yB2,zB1,zB2)%������xy���꣬gn��Ŀ��xy���꣬closed��xy�������ֵ

    
    exp_array=[];%�����������
    exp_count=1;%���������ʼֵΪ1
    c2=size(CLOSED,1);% c2Ϊclosed�н��ĸ�����������ʼ��
    for k= 1:-1:-1%x������ֵ����ֵΪ1������-1����ֵ-1
        for j= 1:-1:-1
            for i= 1:-1:-1  % ����һ��������ڵļ�����
                if (k~=j || k~=i || k~=0)% k=j=0ʱΪ�٣�1,1��1,0��0,1�����������ǵ�ǰ��ʱ����
                    s_x = node_x+k;
                    s_y = node_y+j;
                    s_z = node_z+i;
                    if( (s_x >=xB1 && s_x <=xB2) && (s_y >=yB1 && s_y <=yB2) && (s_z >=zB1 && s_z <=zB2))%�жϽ���Ƿ�����������ڣ�xy�������0��С������ޣ�
                        flag=1;%���Ϊ��ͨ��                    
                        for c1=1:c2
                            if(s_x == CLOSED(c1,1) && s_y == CLOSED(c1,2) && s_z == CLOSED(c1,3))%����������closed��
                               flag=0;%���Ϊ�ϰ���
                            end;
                        end;% ����������Ƿ���closed��
                        if (flag == 1)% ����ͨ���Ҳ���closed��
                            exp_array(exp_count,1) = s_x;%����ȡ�����������
                            exp_array(exp_count,2) = s_y;
                            exp_array(exp_count,3) = s_z;
                            exp_array(exp_count,4) = gn+distance(node_x,node_y,node_z,s_x,s_y,s_z);%gn����ԭgn�ӵ�ǰ�㵽������ľ���
                            exp_array(exp_count,5) = distance(xTarget,yTarget,zTarget,s_x,s_y,s_z);%hn����distance������������㵽Ŀ���ľ���
                            exp_array(exp_count,6) = exp_array(exp_count,4)+exp_array(exp_count,5);%fn=hn+gn
                            exp_count=exp_count+1;
                        end%������exp��
                    end
                end
            end%%%%%%%%%%%%i loop
        end
    end 