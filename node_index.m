function n_index = node_index(OPEN,xval,yval,zval)

    i=1;
    while(OPEN(i,2) ~= xval || OPEN(i,3) ~= yval || OPEN(i,4) ~= zval )%%%%%%%%%%%%��OPEN���н�����겻�������������
        i=i+1;
    end;%ͳ��·����㵽������ǰ�����Ľ����
    n_index=i;%����ֵΪ�����
end