%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OPEN=[];%����open��
CLOSED=[];%����closed��

%%%%%%%%%%%%%%�������ϰ���ŵ�closed��%%%%%%%%%%%%%
k=1;%���������
for i=1:MAX_X
    for j=1:MAX_Y
        for s=1:MAX_Z
            if(MAP(i,j,s) == -1 || MAP(i,j,s)==-2) %���ж�Ϊ�ϰ���
               CLOSED(k,1)=i; %x����浽closed��
               CLOSED(k,2)=j; 
               CLOSED(k,3)=s; 
               k=k+1;
            end
        end
    end
end

CLOSED_COUNT=size(CLOSED,1); %CLOSED_COUNTΪ����CLOSED�еĸ�����1��ʾ�У�2��ʾ�У�

xNode=xStart; 
yNode=yStart;
zNode=zStart;
OPEN_COUNT=1; 
path_cost=0; %·�����۳�ֵ��Ϊ0����gn=0
goal_distance=distance(xNode,yNode,zNode,xTarget,yTarget,zTarget); %Ŀ����뼴hn,Ϊdistance��������ֵ
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,zNode,xNode,yNode,zNode,path_cost,goal_distance,goal_distance); %��ʼ�����open��һ��
OPEN(OPEN_COUNT,1)=0; %��ʼ�㲻��open����
CLOSED_COUNT=CLOSED_COUNT+1; 
CLOSED(CLOSED_COUNT,1)=xNode;%��ʼ�����closed���+1��
CLOSED(CLOSED_COUNT,2)=yNode;
CLOSED(CLOSED_COUNT,3)=zNode;
NoPath=1;% ·��������񣬳�ʼֵ����������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget || yNode ~= yTarget || zNode ~= zTarget) && NoPath == 1)%x�����y���겻����Ŀ�����
    exp_array=expand_array_global(xNode,yNode,zNode,path_cost,xTarget,yTarget,zTarget,CLOSED,MAX_X,MAX_Y,MAX_Z);
    exp_count=size(exp_array,1);%exp_countΪ���ڵ�ĸ���

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�ÿ�ͨ���Ľ�����OPEN���þ����Ľ�����CLOSED��%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%��չ���ռ�%%%%%%%%%%%% 
    for i=1:exp_count
        flag=0;
        for j=1:OPEN_COUNT
            if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) && exp_array(i,3) == OPEN(j,4) )%��exp��open�е�x���������y����Ҳ���
               OPEN(j,10)=min(OPEN(j,10),exp_array(i,6)); % fnȡopen��exp������С��һ��
               if OPEN(j,10)== exp_array(i,6)%��open��exp�е�fn���
                %����˫�׽�㣬gn��hn
                  OPEN(j,5)=xNode;%open��˫�׽�����Ϊ��ǰ��
                  OPEN(j,6)=yNode;
                  OPEN(j,7)=zNode;
                  OPEN(j,8)=exp_array(i,4);%open��gn����Ϊexp��gn
                  OPEN(j,9)=exp_array(i,5);%hn
               end;%��Сfn����
               flag=1;
            end
        end
        if flag == 0 % ���OPEN��û��exp�õ㣬������ӽ�ȥ������node��Ϊ�½���˫�׽��
           OPEN_COUNT = OPEN_COUNT+1;
           OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),exp_array(i,3),xNode,yNode,zNode,exp_array(i,4),exp_array(i,5),exp_array(i,6));
        end;%������Ԫ�ص�open��
    end;
 
   %%%%%%%%%%�ҵ�fn��С����һ����·�㣬ת��%%%%%%%%%
    index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget,zTarget,0,0,0);
   
    %%%%%%%%��ֹ��������%%%%%%%%
%    if abs(OPEN(index_min_node,2)-xNode)==1 && abs(OPEN(index_min_node,3)-yNode)==1 
%        if MAP(xNode,OPEN(index_min_node,3),OPEN(index_min_node,4))<0 && MAP(OPEN(index_min_node,2),yNode,OPEN(index_min_node,4))>=0
%            OPEN(index_min_node,3)=yNode;  
%        else
%            if MAP(OPEN(index_min_node,2),yNode,OPEN(index_min_node,4))<0 && MAP(xNode,OPEN(index_min_node,3),OPEN(index_min_node,4))>=0
%               OPEN(index_min_node,2)=xNode;
%            else
%                if MAP(OPEN(index_min_node,2),yNode,OPEN(index_min_node,4))<0 && MAP(yNode,OPEN(index_min_node,3),OPEN(index_min_node,4))<0
%                   
%                end
%            end  
%        end
%    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    if (index_min_node ~= -1) %��������С�㲻Ϊ-1�����ڵ���Ŀ����·��
   %%%%%%%%����ǰ��ת�Ƶ�fn��С�ĵ���%%%%%%%%%
        xNode=OPEN(index_min_node,2);
        yNode=OPEN(index_min_node,3);
        zNode=OPEN(index_min_node,4);
        path_cost=OPEN(index_min_node,8);%Update the cost of reaching the parent node ���µ���˫�׽��Ĵ��ۣ���gn
   %%%%%%%������Ƶ�closed��%%%%%%%%
        CLOSED_COUNT=CLOSED_COUNT+1;
        CLOSED(CLOSED_COUNT,1)=xNode; 
        CLOSED(CLOSED_COUNT,2)=yNode;
        CLOSED(CLOSED_COUNT,3)=zNode;
        OPEN(index_min_node,1)=0;%OPEN����ɾ���õ㣬is on list=0
    else
        NoPath=0;%�˳�ѭ��
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����һ����·�㿪ʼ���򵽴���ʼ�㣬����Optimal_path%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i=size(CLOSED,1);
xval=CLOSED(i,1);
yval=CLOSED(i,2);
zval=CLOSED(i,3);
i=1;
Optimal_path=[];
Optimal_path(i,1)=xval; % �Ȱ���󾭹��ĺ�·�����·����
Optimal_path(i,2)=yval;
Optimal_path(i,3)=zval;
i=i+1;

%%%%%%%%%ͨ��˫�׽�㽫ÿ����·�㷴�����Optimal_path��%%%%%%%%%%%%%%
if ( (xval == xTarget) && (yval == yTarget) && (zval == zTarget))
    inode=0;
  
    parent_x=OPEN(node_index(OPEN,xval,yval,zval),5);
    parent_y=OPEN(node_index(OPEN,xval,yval,zval),6);
    parent_z=OPEN(node_index(OPEN,xval,yval,zval),7);
   
    while( parent_x ~= xStart || parent_y ~= yStart || parent_z ~= zStart)%��˫�׽�㲻����ʼ��ʱ
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           Optimal_path(i,3) = parent_z;
           %�ҵ��游ĸ���
           inode=node_index(OPEN,parent_x,parent_y,parent_z);
           parent_x=OPEN(inode,5);
           parent_y=OPEN(inode,6);
           parent_z=OPEN(inode,7);
           i=i+1;
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʾȫ�ֹ滮·��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x,y,z]=sphere(50);%��������ֵ�ǹ⻬�ȣ�
    r=1.45;
 
    plot3(xStart+.5,yStart+.5,zStart+.5,'bo','MarkerFaceColor','b','MarkerSize',7);%��ʾ��ʼ�� 
 
    j=size(Optimal_path,1);
    Optimal_path(j+1,1)=xStart;
    Optimal_path(j+1,2)=yStart;
    Optimal_path(j+1,3)=zStart;
    j=size(Optimal_path,1);
    p=plot3(Optimal_path(j,1)+.5,Optimal_path(j,2)+.5,Optimal_path(j,3)+.5,'o','MarkerFaceColor','g','MarkerSize',7);%��ʾ��һ����·��

    
 %%%%%%%%%%%%%%%%%%����̬��ʾ��·��%%%%%%%%%%%%%%%%%%%
    j=j-1;
    for i=j:-1:1%�ݼ�
        pause(.25);
        set(p,'XData',Optimal_path(i,1)+.5,'YData',Optimal_path(i,2)+.5,'ZData',Optimal_path(i,3)+.5);
        drawnow ;
    end
    
    %%%%%%%%%%%%%%%%%%��ʾ����%%%%%%%%%%%%%%%%%%%%%
    values = spcrv([Optimal_path(:,1)'+.5;Optimal_path(:,2)'+.5;Optimal_path(:,3)'+.5],3);
    h=plot3(values(1,:),values(2,:),values(3,:),'m','LineWidth',2); % ��ʾƽ���켣
end

