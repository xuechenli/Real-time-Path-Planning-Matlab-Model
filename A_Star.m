%A_Star(xNode,yNode,zNode,xTarget,yTarget,zTarget,xB1,xB2,yB1,yB2,zB1,zB2,MAP)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OPEN���ĽṹΪ��
%--------------------------------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Z val |Parent X val |Parent Y val |Parent Z val |h(n) |g(n) |f(n) |
%--------------------------------------------------------------------------------------------------
OPEN=[];%����open��

%CLOSED���ĽṹΪ��
%------------------------
%X val | Y val | Z val |
%------------------------
% CLOSED=zeros(MAX_VAL,3); Ԫ�ؾ�Ϊ0��10x3�ľ���
CLOSED=[];%����closed��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CLOSED_COUNT=size(CLOSED,1); %CLOSED_COUNTΪ����CLOSED�еĸ�����1��ʾ�У�2��ʾ�У�
OPEN_COUNT=1; 
goal_distance=distance(xNode,yNode,zNode,xTarget,yTarget,zTarget); %Ŀ����뼴hn,Ϊdistance��������ֵ
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,zNode,xNode,yNode,zNode,path_cost,goal_distance,goal_distance); %��ʼ�����open��һ��
OPEN(OPEN_COUNT,1)=0; %��ʼ���open��ɾ�� 
CLOSED_COUNT=CLOSED_COUNT+1; 
CLOSED(CLOSED_COUNT,1)=xNode;%��ʼ�����closed���+1��
CLOSED(CLOSED_COUNT,2)=yNode;
CLOSED(CLOSED_COUNT,3)=zNode;
NoPath=1;% ·��������񣬳�ʼֵ����������

%%%%%%%%%%%%%%�������ϰ���ŵ�closed��%%%%%%%%%%%%%
for i=xB1:xB2
        for j=yB1:yB2
            for s=zB1:zB2
                if(MAP(i,j,s) == -1) %���ж�Ϊ�ϰ���
%                    MAP(i,j,s)=-2;%��ʾ�Ѿ�������ϰ�����Ϣ
                    CLOSED_COUNT=CLOSED_COUNT+1;
                    CLOSED(CLOSED_COUNT,1)=i; %x����浽closed��
                    CLOSED(CLOSED_COUNT,2)=j; 
                    CLOSED(CLOSED_COUNT,3)=s; 
                end
            end
        end
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%while((xNode ~= xTarget || yNode ~= yTarget || zNode ~= zTarget) && NoPath == 1)


    exp_array=expand_array(xNode,yNode,zNode,path_cost,xTarget,yTarget,zTarget,CLOSED,xB1,xB2,yB1,yB2,zB1,zB2);
    %----------------------��ʼ��xyz���꣬    0��       Ŀ���xyz���꣬          closed����10,10,10
    exp_count=size(exp_array,1);%exp_countΪ���ڵ�ĸ���
 
    %OPEN���Ľṹ
    %--------------------------------------------------------------------------------------------------
    %IS ON LIST 1/0 |X val |Y val |Z val |Parent X val |Parent Y val |Parent Z val |g(n) |h(n) |f(n) |
    %--------------------------------------------------------------------------------------------------
    %EXPANDED ARRAY �Ľṹ
    %------------------------------------------
    %|X val |Y val |Z val ||g(n) |h(n) |f(n) |
    %------------------------------------------
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�ÿ�ͨ���Ľ�����OPEN�����þ����Ľ�����CLOSED��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%��չ���ռ�%%%%%%%%%%%% 
    
    for i=1:exp_count
%%%%%%%%%%%%%%%%%%%%%%%%%%��ζ����Բ�Ҫ��%%%%%%%%��ʼ%%%%%%%%%%%%%%%%%%%%        
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
            end;
        end;
        if flag == 0 % ���OPEN��û��exp�õ㣬�������ӽ�ȥ������node��Ϊ�½���˫�׽��
%%%%%%%%%%%%%%%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
           OPEN_COUNT = OPEN_COUNT+1;
           OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),exp_array(i,3),xNode,yNode,zNode,exp_array(i,4),exp_array(i,5),exp_array(i,6));
        end;%������Ԫ�ص�open��
    end;
 
   %%%%%%%%%%�ҵ�fn��С����һ����·�㣬ת��%%%%%%%%%
    index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget,zTarget,encounter,NP,NP_COUNT);
    
    
    if (index_min_node ~= -1) %��������С�㲻Ϊ-1�����ڵ���Ŀ����·��
   %%%%%%%%����ǰ��ת�Ƶ�fn��С�ĵ���%%%%%%%%%
        xNode=OPEN(index_min_node,2);
        yNode=OPEN(index_min_node,3);
        zNode=OPEN(index_min_node,4);
        path_cost=OPEN(index_min_node,8);%Update the cost of reaching the parent node ���µ���˫�׽��Ĵ��ۣ���gn
   %%%%%%%������Ƶ�closed��%%%%%%%%
   %     CLOSED_COUNT=CLOSED_COUNT+1;
   %     CLOSED(CLOSED_COUNT,1)=xNode; 
   %     CLOSED(CLOSED_COUNT,2)=yNode;
   %     CLOSED(CLOSED_COUNT,3)=zNode;
   %     OPEN(index_min_node,1)=0;%OPEN����ɾ���õ㣬is on list=0
    else
        NoPath=0;%�˳�ѭ��
    end;
    
%end



    




