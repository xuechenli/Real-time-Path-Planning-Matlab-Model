function i_min = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget,zTarget,encounter,NP,NP_COUNT)


 temp_array=[];%������ʱ����
 k=1;
 flag=0;
 goal_index=0;%Ŀ��������ֵΪ0
 if encounter~=1
    for j=1:OPEN_COUNT%j��ֵΪ1����ֵΪopen������
        if (OPEN(j,1)==1)%���õ��Ѿ���open����
            temp_array(k,:)=[OPEN(j,:) j]; %temp_array��k�д�ɺ��е�ĸ�����ֵ��open���j�У������
            if (OPEN(j,2)==xTarget && OPEN(j,3)==yTarget && OPEN(j,4)==zTarget)
                flag=1;%��open�����ҵ�Ŀ���
                goal_index=j;%�������
            end;
            k=k+1;
        end;
    end;%���������open���еĵ�
    
 else
    for j=1:OPEN_COUNT%j��ֵΪ1����ֵΪopen������
        f=0;
        for t=1:NP_COUNT
            if (OPEN(j,1)~=1 || ( OPEN(j,2)==NP(t,1) && OPEN(j,3)==NP(t,2) && OPEN(j,4)==NP(t,3) ))%���õ��Ѿ���open����
                f=1;
            end
        end

        if f==0 %���õ��ڱ����Ҳ�ΪNP��
            temp_array(k,:)=[OPEN(j,:) j]; %temp_array��k�д�ɺ��е�ĸ�����ֵ��open���j�У������
            if (OPEN(j,2)==xTarget && OPEN(j,3)==yTarget && OPEN(j,4)==zTarget)
                flag=1;%��open�����ҵ�Ŀ���
                goal_index=j;%�������
            end;
            k=k+1;
        end
    end
 end%���������open���еĵ�

 
 
 if flag == 1 %��һ���̳е����Ŀ��� 
     i_min=goal_index;%�õ����Ϊ����ֵ
 end

 if size(temp_array ~= 0)
  [min_fn,temp_min]=min(temp_array(:,10));%ȡtemp_array��10�У���fn����С������
  i_min=temp_array(temp_min,11);%ȡtemp_array��11�У�����ţ�Ϊ����ֵ 
 else
     i_min=-1;%temp_array�ǿյģ���û�п���·��
 end
 
 
 
end